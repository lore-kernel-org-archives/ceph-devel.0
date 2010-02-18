From: Andreas Hirczy <ahi@itp.tugraz.at>
Subject: Re: v0.19 released
Date: Thu, 18 Feb 2010 13:22:57 +0100
Message-ID: <8atytevila.fsf@faepop01.tu-graz.ac.at>
References: <Pine.LNX.4.64.1002171440270.10839@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1002171440270.10839@cobra.newdream.net> (Sage
	Weil's message of "Wed, 17 Feb 2010 14:47:31 -0800 (PST)")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

Sage Weil <sage@newdream.net> writes:

> The v0.19 release is finally here.  The focus this past cycle was on 
> ...
>     * For Debian packages see http://ceph.newdream.net/wiki/Debian

Hi!

It seems the debian packages for "ceph-kclient-source" miss a
Makefile. I transplanted one from the git repo; this works as outlined
in <http://ceph.newdream.net/wiki/Building_kernel_client>, but not with
"make-kpkg":

###########################################
make[1]: Entering directory `/usr/src/modules/ceph'
fakeroot /usr/bin/make -w -f debian/rules kdist_clean kdist_config binary-modules
make[2]: Entering directory `/usr/src/modules/ceph'
make[3]: Entering directory `/usr/src/modules/ceph'
/usr/bin/make -C /usr/src/linux-2.6.32.7 M=/usr/src/modules/ceph clean
make[4]: Entering directory `/usr/src/linux-2.6.32.7'
make[4]: Leaving directory `/usr/src/linux-2.6.32.7'
make[3]: Leaving directory `/usr/src/modules/ceph'
make[2]: Nothing to be done for `kdist_config'.
for templ in ; do \
    cp $templ `echo $templ | sed -e 's/_KVERS_/2.6.32.8/g'` ; \
  done
for templ in `ls debian/*.modules.in` ; do \
    test -e ${templ%.modules.in}.backup || cp ${templ%.modules.in} ${templ%.modules.in}.backup 2>/dev/null || true; \
    sed -e 's/##KVERS##/2.6.32.8/g ;s/#KVERS#/2.6.32.8/g ; s/_KVERS_/2.6.32.8/g ; s/##KDREV##/itp.1/g ; s/#KDREV#/itp.1/g ; s/_KDREV_/itp.1/g  ' < $templ > ${templ%.modules.in}; \
  done
ls: cannot access debian/*.modules.in: No such file or directory
dh_testroot
dh_clean -k
/usr/bin/make KERNELDIR=/usr/src/linux-2.6.32.7 all
make[3]: Entering directory `/usr/src/modules/ceph'
/usr/bin/make -C /usr/src/linux-2.6.32.7 M=/usr/src/modules/ceph CONFIG_CEPH_FS=m modules
make[4]: Entering directory `/usr/src/linux-2.6.32.7'
  CC [M]  /usr/src/modules/ceph/super.o
  CC [M]  /usr/src/modules/ceph/inode.o
  CC [M]  /usr/src/modules/ceph/dir.o
  CC [M]  /usr/src/modules/ceph/file.o
  CC [M]  /usr/src/modules/ceph/addr.o
  CC [M]  /usr/src/modules/ceph/ioctl.o
  CC [M]  /usr/src/modules/ceph/export.o
  CC [M]  /usr/src/modules/ceph/caps.o
  CC [M]  /usr/src/modules/ceph/snap.o
  CC [M]  /usr/src/modules/ceph/xattr.o
  CC [M]  /usr/src/modules/ceph/messenger.o
  CC [M]  /usr/src/modules/ceph/msgpool.o
  CC [M]  /usr/src/modules/ceph/buffer.o
  CC [M]  /usr/src/modules/ceph/pagelist.o
  CC [M]  /usr/src/modules/ceph/mds_client.o
  CC [M]  /usr/src/modules/ceph/mdsmap.o
  CC [M]  /usr/src/modules/ceph/mon_client.o
  CC [M]  /usr/src/modules/ceph/osd_client.o
  CC [M]  /usr/src/modules/ceph/osdmap.o
  CC [M]  /usr/src/modules/ceph/crush/crush.o
  CC [M]  /usr/src/modules/ceph/crush/mapper.o
  CC [M]  /usr/src/modules/ceph/crush/hash.o
  CC [M]  /usr/src/modules/ceph/debugfs.o
  CC [M]  /usr/src/modules/ceph/auth.o
  CC [M]  /usr/src/modules/ceph/auth_none.o
  CC [M]  /usr/src/modules/ceph/crypto.o
  CC [M]  /usr/src/modules/ceph/armor.o
  CC [M]  /usr/src/modules/ceph/auth_x.o
  CC [M]  /usr/src/modules/ceph/ceph_fs.o
  CC [M]  /usr/src/modules/ceph/ceph_strings.o
  CC [M]  /usr/src/modules/ceph/ceph_hash.o
  CC [M]  /usr/src/modules/ceph/ceph_frag.o
  LD [M]  /usr/src/modules/ceph/ceph.o
  Building modules, stage 2.
  MODPOST 1 modules
  CC      /usr/src/modules/ceph/ceph.mod.o
  LD [M]  /usr/src/modules/ceph/ceph.ko
make[4]: Leaving directory `/usr/src/linux-2.6.32.7'
make[3]: Leaving directory `/usr/src/modules/ceph'
mkdir -p ./debian/ceph-modules-2.6.32.8/lib/modules/2.6.32.8/kernel/fs/ceph
cp ceph.ko ./debian/ceph-modules-2.6.32.8/lib/modules/2.6.32.8/kernel/fs/ceph/
dh_installdocs
dh_installchangelogs
dh_compress
dh_fixperms
dh_strip
dh_installmodules
dh_install
dh_install: ceph-kclient-source missing files (usr/src/*), aborting
make[2]: *** [binary-modules] Error 1
make[2]: Leaving directory `/usr/src/modules/ceph'
make[1]: *** [kdist_build] Error 2
make[1]: Leaving directory `/usr/src/modules/ceph'
Module /usr/src/modules/ceph failed.
Perhaps /usr/src/modules/ceph does not understand --rootcmd?
If you see messages that indicate that it is not
in fact being built as root, please file a bug 
against /usr/src/modules/ceph.
Hit return to Continue
###########################################

Best regards,
Andreas
-- 
Andreas Hirczy <ahi@itp.tugraz.at>                   http://itp.tugraz.at/~ahi/
Graz University of Technology                        phone: +43/316/873-   8190
Institute of Theoretical and Computational Physics     fax: +43/316/873-10 8190
Petersgasse 16, A-8010 Graz                         mobile: +43/664/859 23 57

------------------------------------------------------------------------------
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs 
proactively, and fine-tune applications for parallel performance. 
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
