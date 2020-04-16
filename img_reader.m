
%%% written by D.S.JOKHUN on 10/04/2015

function Image=img_reader(Filename)



Reader = bfGetReader (Filename);
OmeMeta = Reader.getMetadataStore();

MetaData.Num_of_Ch = OmeMeta.getPixelsSizeC(0).getValue();
MetaData.Num_of_Pixels_Z = OmeMeta.getPixelsSizeZ(0).getValue();
MetaData.Num_of_Pixels_X = OmeMeta.getPixelsSizeX(0).getValue();
MetaData.Num_of_Pixels_Y = OmeMeta.getPixelsSizeY(0).getValue();
MetaData.Voxel_Size_X = double(OmeMeta.getPixelsPhysicalSizeX(0).value(ome.units.UNITS.MICROM)); % in µm
MetaData.Voxel_Size_Y = double(OmeMeta.getPixelsPhysicalSizeY(0).value(ome.units.UNITS.MICROM)); % in µm
MetaData.Voxel_Size_Z = double(OmeMeta.getPixelsPhysicalSizeZ(0).value(ome.units.UNITS.MICROM)); % in µm

Image=cell(MetaData.Num_of_Ch+1,1);
Image{end}=MetaData;

iSeries = 1;
iT=1;

Reader.setSeries(iSeries - 1);

for iCh=1:MetaData.Num_of_Ch
    XYZ_temp =uint16([]);
    for iZ=1:MetaData.Num_of_Pixels_Z
        iPlane = Reader.getIndex(iZ-1, iCh-1, iT-1) + 1;   
        XYZ_temp(:,:,iZ)= bfGetPlane(Reader, iPlane);
    end
    Image{iCh}=XYZ_temp;   
end



end
