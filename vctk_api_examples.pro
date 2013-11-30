pro vctk_single_file_example
  compile_opt idl2

  file = 'C:\Users\Devin White\Desktop\test\VIIRS\Full\GMODO-SVM01-SVM02-SVM03-SVM04-SVM05-SVM06-SVM07-SVM08-SVM09-SVM10-SVM11-SVM12-SVM13-SVM14-SVM15-SVM16_npp_d20121201_t0838366_e0844170_b05675_c20121211031321430582_noaa_ops.h5'
  out_root = 'test_output'
  out_path = 'C:\Users\Devin White\Desktop\test\VIIRS\Full\'

  proj = envi_proj_create(/geographic)
  
  bridges = vctk_create_bridges()
  
  ;convert M-Band data to reflectance and temperature instead of radiance
  viirs_convert_data, file=file, out_root=out_root, out_path=out_path, georef=1, msg=msg, $
    proj=proj, geo_fid=geo_fid, /refl_temp, resamp=1, /progress, $
    bridges=bridges
  
  vctk_destroy_bridges, bridges
  
  ;if conversion failed, find out why
  if geo_fid eq -1 then print, msg
  
end


pro vctk_single_file_example_with_external_geo
  compile_opt idl2

  file = 'C:\Users\Devin White\Desktop\test\VIIRS\terrain correction\GIMGO-SVI01_npp_d20130601_t0651531_e0657334_b08256_c20130615144826133418_noaa_ops.h5'
  geo_file = 'C:\Users\Devin White\Desktop\test\VIIRS\terrain correction\GITCO_npp_d20130601_t0651531_e0657334_b08256_c20130601125734319886_noaa_ops.h5'
  out_root = 'test_output'
  out_path = 'C:\Users\Devin White\Desktop\test\VIIRS\terrain correction\'

  proj = envi_proj_create(/geographic)
  
  bridges = vctk_create_bridges()
  
  ;convert M-Band data to reflectance and temperature instead of radiance
  viirs_convert_data, file=file, out_root=out_root, out_path=out_path, georef=1, msg=msg, $
    proj=proj, geo_fid=geo_fid, /refl_temp, resamp=1, /progress, bridges=bridges, $
    geo_file=geo_file
  
  vctk_destroy_bridges, bridges
  
  ;if conversion failed, find out why
  if geo_fid eq -1 then print, msg
  
end


pro vctk_multiple_file_example
  compile_opt idl2
  
  in_dir = 'C:\Users\Devin White\Desktop\test\VIIRS\Mosaic\'
  out_path = 'C:\Users\Devin White\Desktop\test\VIIRS\Mosaic\'
  mosaic_file = 'C:\Users\Devin White\Desktop\test\VIIRS\Mosaic\dnb_mosaic.dat'
  
  files = file_search(in_dir, '*.h5', count=file_count)
  if file_count eq 0 then return
  
  bridges = vctk_create_bridges()  

  ;create a mosaic of radiance DNB files from a folder using default UTM projection
  viirs_batch_conversion, files=files, out_path=out_path, msg=msg, georef=1, $
    geo_fids=geo_fids, resamp=1, /default_utm, /progress, bridges=bridges, $
    /do_mosaic, mosaic_file=mosaic_file, mosaic_fid=mosaic_fid  
  
  vctk_destroy_bridges, bridges

  ;if conversion failed, find out why
  if mosaic_fid eq -1 then print, msg
  
end