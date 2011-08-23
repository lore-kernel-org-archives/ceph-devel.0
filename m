From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] rbd: add an option for md5 checksumming
Date: Tue, 23 Aug 2011 09:19:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108230915430.2477@cobra.newdream.net>
References: <20110823121543.GA9723@sir.fritz.box>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49990 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917Ab1HWQO3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2011 12:14:29 -0400
In-Reply-To: <20110823121543.GA9723@sir.fritz.box>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

Hi Christian,

On Tue, 23 Aug 2011, Christian Brunner wrote:
> We needed to get an md5 checksum of an rbd image. Since librbd is using a
> lot of sparse operations, this was not possible without writing an image
> to a local disk.
> 
> With this patch exporting the image is no longer needed. You can do 
> "rbd md5 image" and you will get the same output as you would call "md5sum".
> 
> Thanks,
> Christian
> ---
>  src/rbd.cc |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 82 insertions(+), 1 deletions(-)
> 
> diff --git a/src/rbd.cc b/src/rbd.cc
> index a18c029..a9c33ad 100644
> --- a/src/rbd.cc
> +++ b/src/rbd.cc
> @@ -38,6 +38,11 @@
>  #include <time.h>
>  #include <sys/ioctl.h>
>  
> +#define CRYPTOPP_ENABLE_NAMESPACE_WEAK 1
> +#include <cryptopp/cryptlib.h>
> +#include <cryptopp/md5.h>
> +#include <cryptopp/hex.h>
> +

We need to build with both cryptopp and libnss.  See common/ceph_crypto.h, 
which defines the SHA1 HMAC.  Adding MD5 should be pretty straightforward.  
We may as well support both, though?


>  #include "include/rbd_types.h"
>  
>  #include <linux/fs.h>
> @@ -49,6 +54,7 @@
>  
>  static string dir_oid = RBD_DIRECTORY;
>  static string dir_info_oid = RBD_INFO;
> +static size_t lastofs;
>  
>  void usage()
>  {
> @@ -65,6 +71,7 @@ void usage()
>         << "  export [image-name] [dest-path]           export image to file\n"
>         << "  import [path] [dst-image]                 import image from file (dest defaults\n"
>         << "                                            as the filename part of file)\n"
> +       << "  md5 [image-name]                          print md5 checksum for image\n"
>         << "  <cp | copy> [src-image] [dest-image]      copy image to dest\n"
>         << "  <mv | rename> [src-image] [dest-image]    copy image to dest\n"
>         << "  snap ls [image-name]                      dump list of image snapshots\n"
> @@ -262,6 +269,66 @@ static int do_export(librbd::Image& image, const char *path)
>    return 0;
>  }
>  
> +static int md5_read_cb(uint64_t ofs, size_t len, const char *buf, void *arg)
> +{
> +  ssize_t dif;
> +  CryptoPP::HashTransformation *Hash = (CryptoPP::HashTransformation *)arg;
> +
> +  dif = ofs-lastofs;
> +  if (dif > 0) {
> +    byte *tempbuf = (byte *) malloc(dif);
> +    memset(tempbuf, 0, dif);
> +    Hash->Update((const byte *) tempbuf, dif);
> +    free(tempbuf);
> +  }
> +
> +  if (buf) {
> +    Hash->Update((const byte *) buf, len);
> +  }

If buf == NULL we are processing a hole.  The zeroes should probably be 
fed to the hash too?

sage



> +
> +  lastofs = ofs + len;
> +
> +  return 0;
> +}
> +
> +static int do_md5(librbd::Image& image, const char *imgname)
> +{
> +  int64_t r;
> +  librbd::image_info_t info;
> +
> +  lastofs = 0;
> +
> +  CryptoPP::HashTransformation *Hash = 
> +    (CryptoPP::HashTransformation *) new CryptoPP::Weak1::MD5;
> +
> +  r = image.stat(info, sizeof(info));
> +  if (r < 0)
> +    return r;
> +
> +  r = image.read_iterate(0, info.size, md5_read_cb, (void *)Hash);
> +  if (r < 0)
> +    return r;
> +
> +  if (lastofs < info.size) {
> +      md5_read_cb(info.size, 0, NULL, (void *)Hash);
> +  }
> +
> +  byte digest[CryptoPP::Weak1::MD5::DIGESTSIZE];
> +  Hash->Final(digest);
> +
> +  std::string output;
> +  CryptoPP::StringSource(digest, sizeof(digest), true,
> +    new CryptoPP::HexEncoder(
> +        new CryptoPP::StringSink(output),
> +	false
> +    ) 
> +  );
> +
> +  cout << output << " " << imgname << std::endl;
> +
> +  return 0;
> +}
> +
>  static const char *imgname_from_path(const char *path)
>  {
>    const char *imgname;
> @@ -739,6 +806,7 @@ enum {
>    OPT_MAP,
>    OPT_UNMAP,
>    OPT_SHOWMAPPED,
> +  OPT_MD5,
>  };
>  
>  static int get_cmd(const char *cmd, bool *snapcmd)
> @@ -766,6 +834,8 @@ static int get_cmd(const char *cmd, bool *snapcmd)
>        return OPT_EXPORT;
>      if (strcmp(cmd, "import") == 0)
>        return OPT_IMPORT;
> +    if (strcmp(cmd, "md5") == 0)
> +      return OPT_MD5;
>      if (strcmp(cmd, "copy") == 0 ||
>          strcmp(cmd, "cp") == 0)
>        return OPT_COPY;
> @@ -888,6 +958,9 @@ int main(int argc, const char **argv)
>            case OPT_IMPORT:
>              set_conf_param(CEPH_ARGPARSE_VAL, &path, &destname);
>              break;
> +          case OPT_MD5:
> +            set_conf_param(CEPH_ARGPARSE_VAL, &imgname, NULL);
> +            break;
>            case OPT_COPY:
>            case OPT_RENAME:
>              set_conf_param(CEPH_ARGPARSE_VAL, &imgname, &destname);
> @@ -966,7 +1039,7 @@ int main(int argc, const char **argv)
>        (opt_cmd == OPT_RESIZE || opt_cmd == OPT_INFO || opt_cmd == OPT_SNAP_LIST ||
>         opt_cmd == OPT_SNAP_CREATE || opt_cmd == OPT_SNAP_ROLLBACK ||
>         opt_cmd == OPT_SNAP_REMOVE || opt_cmd == OPT_EXPORT || opt_cmd == OPT_WATCH ||
> -       opt_cmd == OPT_COPY)) {
> +       opt_cmd == OPT_COPY || opt_cmd == OPT_MD5)) {
>      r = rbd.open(io_ctx, image, imgname);
>      if (r < 0) {
>        cerr << "error opening image " << imgname << ": " << strerror(r) << std::endl;
> @@ -1127,6 +1200,14 @@ int main(int argc, const char **argv)
>      }
>      break;
>  
> +  case OPT_MD5:
> +    r = do_md5(image, imgname);
> +    if (r < 0) {
> +      cerr << "md5 hashing failed: " << strerror(-r) << std::endl;
> +      exit(1);
> +    }
> +    break;
> +
>    case OPT_COPY:
>      r = do_copy(image, dest_io_ctx, destname);
>      if (r < 0) {
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
