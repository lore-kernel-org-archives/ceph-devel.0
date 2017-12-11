From: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph-disk activation issue in 12.2.2
Date: Mon, 11 Dec 2017 10:26:30 +0530
Message-ID: <CALWuvY9NCzSZ9rRoWmUz8aVPtThjO5BKDaPLhoxU7i7AO_KG0w@mail.gmail.com>
References: <CALWuvY-P-HT6ZRSxOMvvbbaku7XeQfS_P+8+iFmkb-oyhfaDJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2939896361570827201=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALWuvY-P-HT6ZRSxOMvvbbaku7XeQfS_P+8+iFmkb-oyhfaDJQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2939896361570827201==
Content-Type: multipart/alternative; boundary="001a113db9548d8c990560095b50"

--001a113db9548d8c990560095b50
Content-Type: text/plain; charset="UTF-8"

Created tracker for this issue -- > http://tracker.ceph.com/issues/22354

Thanks
Jayaram

On Fri, Dec 8, 2017 at 9:49 PM, nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hello Team,
>
> We aware that ceph-disk which is deprecated in 12.2.2 . As part of my
> testing, I can still using this ceph-disk utility for creating OSD's in
> 12.2.2
>
> Here I'm getting activation error on the second hit onwards.
>
> First occurance  OSD's creating without any issue.
> =======================================
>
> ## ceph-disk prepare --bluestore --cluster ceph --cluster-uuid
> b2f1b9b9-eecc-4c17-8b92-cfa60b31c121 /dev/sde; ceph-disk activate
> /dev/sde1
> /usr/lib/python2.7/site-packages/ceph_disk/main.py:5653: UserWarning:
> ************************************************************
> *******************
> This tool is now deprecated in favor of ceph-volume.
> It is recommended to use ceph-volume for OSD deployments. For details see:
>
>     http://docs.ceph.com/docs/master/ceph-volume/#migrating
>
> ************************************************************
> *******************
>
>   warnings.warn(DEPRECATION_WARNING)
> Creating new GPT entries.
> The operation has completed successfully.
> The operation has completed successfully.
> The operation has completed successfully.
> meta-data=/dev/sde1              isize=2048   agcount=4, agsize=6336 blks
>          =                       sectsz=512   attr=2, projid32bit=1
>          =                       crc=1        finobt=0, sparse=0
> data     =                       bsize=4096   blocks=25344, imaxpct=25
>          =                       sunit=64     swidth=64 blks
> naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> log      =internal log           bsize=4096   blocks=1728, version=2
>          =                       sectsz=512   sunit=64 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> Warning: The kernel is still using the old partition table.
> The new table will be used at the next reboot.
> The operation has completed successfully.
> /usr/lib/python2.7/site-packages/ceph_disk/main.py:5685: UserWarning:
> ************************************************************
> *******************
> This tool is now deprecated in favor of ceph-volume.
> It is recommended to use ceph-volume for OSD deployments. For details see:
>
>     http://docs.ceph.com/docs/master/ceph-volume/#migrating
>
> ************************************************************
> *******************
>
>   warnings.warn(DEPRECATION_WARNING)
> /usr/lib/python2.7/site-packages/ceph_disk/main.py:5653: UserWarning:
> ************************************************************
> *******************
> This tool is now deprecated in favor of ceph-volume.
> It is recommended to use ceph-volume for OSD deployments. For details see:
>
>     http://docs.ceph.com/docs/master/ceph-volume/#migrating
>
> ************************************************************
> *******************
>
>   warnings.warn(DEPRECATION_WARNING)
> got monmap epoch 3
> 2017-12-08 16:07:57.262854 7fe58f6e6d00 -1 key
> 2017-12-08 16:07:57.769048 7fe58f6e6d00 -1 created object store
> /var/lib/ceph/tmp/mnt.dTiXMX for osd.16 fsid b2f1b9b9-eecc-4c17-8b92-
> cfa60b31c121
> Removed symlink /run/systemd/system/ceph-osd.target.wants/ceph-osd@16.
> service.
> Created symlink from /run/systemd/system/ceph-osd.
> target.wants/ceph-osd-yfPNuln6L9eKtF1m3vyIGg@public.gmane.org to /usr/lib/systemd/system/ceph-osd@
> .service.
>
> ---
>
>
> On the second occurance. , I'm getting below issue...
> ========================================
>
> # ceph-disk prepare --bluestore --cluster ceph --cluster-uuid
> b2f1b9b9-eecc-4c17-8b92-cfa60b31c121 /dev/sde; ceph-disk activate
> /dev/sde1
> /usr/lib/python2.7/site-packages/ceph_disk/main.py:5653: UserWarning:
> ************************************************************
> *******************
> This tool is now deprecated in favor of ceph-volume.
> It is recommended to use ceph-volume for OSD deployments. For details see:
>
>     http://docs.ceph.com/docs/master/ceph-volume/#migrating
>
> ************************************************************
> *******************
>
>   warnings.warn(DEPRECATION_WARNING)
> Creating new GPT entries.
> The operation has completed successfully.
> The operation has completed successfully.
> The operation has completed successfully.
> meta-data=/dev/sde1              isize=2048   agcount=4, agsize=6336 blks
>          =                       sectsz=512   attr=2, projid32bit=1
>          =                       crc=1        finobt=0, sparse=0
> data     =                       bsize=4096   blocks=25344, imaxpct=25
>          =                       sunit=64     swidth=64 blks
> naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> log      =internal log           bsize=4096   blocks=1728, version=2
>          =                       sectsz=512   sunit=64 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> Warning: The kernel is still using the old partition table.
> The new table will be used at the next reboot.
> The operation has completed successfully.
> /usr/lib/python2.7/site-packages/ceph_disk/main.py:5685: UserWarning:
> ************************************************************
> *******************
> This tool is now deprecated in favor of ceph-volume.
> It is recommended to use ceph-volume for OSD deployments. For details see:
>
>     http://docs.ceph.com/docs/master/ceph-volume/#migrating
>
> ************************************************************
> *******************
>
>   warnings.warn(DEPRECATION_WARNING)
> /usr/lib/python2.7/site-packages/ceph_disk/main.py:5653: UserWarning:
> ************************************************************
> *******************
> This tool is now deprecated in favor of ceph-volume.
> It is recommended to use ceph-volume for OSD deployments. For details see:
>
>     http://docs.ceph.com/docs/master/ceph-volume/#migrating
>
> ************************************************************
> *******************
>
>   warnings.warn(DEPRECATION_WARNING)
> got monmap epoch 3
> 2017-12-08 16:09:07.518454 7fa64e12fd00 -1 bluestore(/var/lib/ceph/tmp/mnt.7x0kCL/block)
> _check_or_set_bdev_label bdev /var/lib/ceph/tmp/mnt.7x0kCL/block fsid
> 54954cfd-b7f3-4f74-9b2e-2ef57c5143cc does not match our fsid
> 29262e99-12ff-4c45-9113-8f69830a1a5e
> 2017-12-08 16:09:07.772688 7fa64e12fd00 -1 bluestore(/var/lib/ceph/tmp/mnt.7x0kCL)
> mkfs fsck found fatal error: (5) Input/output error
> 2017-12-08 16:09:07.772723 7fa64e12fd00 -1 OSD::mkfs: ObjectStore::mkfs
> failed with error (5) Input/output error
> 2017-12-08 16:09:07.772823 7fa64e12fd00 -1  ** ERROR: error creating empty
> object store in /var/lib/ceph/tmp/mnt.7x0kCL: (5) Input/output error
> mount_activate: Failed to activate
> Traceback (most recent call last):
>   File "/usr/sbin/ceph-disk", line 9, in <module>
>     load_entry_point('ceph-disk==1.0.0', 'console_scripts', 'ceph-disk')()
>   File "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 5736,
> in run
>     main(sys.argv[1:])
>   File "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 5682,
> in main
>     main_catch(args.func, args)
>   File "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 5710,
> in main_catch
>     func(args)
>   File "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 3761,
> in main_activate
>     reactivate=args.reactivate,
>   File "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 3524,
> in mount_activate
>     (osd_id, cluster) = activate(path, activate_key_template, init)
>   File "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 3701,
> in activate
>     keyring=keyring,
>   File "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 3153,
> in mkfs
>     '--setgroup', get_ceph_group(),
>   File "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 570, in
> command_check_call
>     return subprocess.check_call(arguments)
>   File "/usr/lib64/python2.7/subprocess.py", line 542, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['/usr/bin/ceph-osd', '--cluster',
> 'ceph', '--mkfs', '-i', u'16', '--monmap', '/var/lib/ceph/tmp/mnt.7x0kCL/activate.monmap',
> '--osd-data', '/var/lib/ceph/tmp/mnt.7x0kCL', '--osd-uuid',
> u'29262e99-12ff-4c45-9113-8f69830a1a5e', '--setuser', 'ceph',
> '--setgroup', 'ceph']' returned non-zero exit status 1
>
>
> Do you think is this a bug ? Even I can reproducable it everytime on any
> osd's . On the first time I can recreate OSD's without any problem. second
> time onwards the issue happening.
>
> Need your views on this ... ?
>
> Thanks
> Jayaram
>

--001a113db9548d8c990560095b50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Created tracker for this issue -- &gt;=C2=A0<a href=3D"htt=
p://tracker.ceph.com/issues/22354">http://tracker.ceph.com/issues/22354</a>=
=C2=A0<div><br></div><div>Thanks</div><div>Jayaram</div></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Dec 8, 2017 at 9:49 PM=
, nokia ceph <span dir=3D"ltr">&lt;<a href=3D"mailto:nokiacephusers@gmail.c=
om" target=3D"_blank">nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div dir=3D"ltr">Hello Team,<div><br></div><div=
>We aware that ceph-disk which is deprecated in 12.2.2 . As part of my test=
ing, I can still using this ceph-disk utility for creating OSD&#39;s in 12.=
2.2=C2=A0</div><div><br></div><div>Here I&#39;m getting activation error on=
 the second hit onwards.=C2=A0</div><div><br></div><div>First occurance=C2=
=A0 OSD&#39;s creating without any issue.</div><div>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div><br></div><div>## ceph-disk prepare -=
-bluestore --cluster ceph --cluster-uuid b2f1b9b9-eecc-4c17-8b92-<wbr>cfa60=
b31c121 /dev/sde; ceph-disk activate /dev/sde1</div><div>/usr/lib/python2.7=
/site-<wbr>packages/ceph_disk/main.py:<wbr>5653: UserWarning:</div><div>***=
***************************<wbr>******************************<wbr>********=
***********</div><div>This tool is now deprecated in favor of ceph-volume.<=
/div><div>It is recommended to use ceph-volume for OSD deployments. For det=
ails see:</div><div><br></div><div>=C2=A0 =C2=A0 <a href=3D"http://docs.cep=
h.com/docs/master/ceph-volume/#migrating" target=3D"_blank">http://docs.cep=
h.com/docs/<wbr>master/ceph-volume/#migrating</a></div><div><br></div><div>=
******************************<wbr>******************************<wbr>*****=
**************</div><div><br></div><div>=C2=A0 warnings.warn(DEPRECATION_<w=
br>WARNING)</div><div>Creating new GPT entries.</div><div>The operation has=
 completed successfully.</div><div>The operation has completed successfully=
.</div><div>The operation has completed successfully.</div><div>meta-data=
=3D/dev/sde1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isize=3D2048=
=C2=A0 =C2=A0agcount=3D4, agsize=3D6336 blks</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0sectsz=3D512=C2=A0 =C2=A0attr=3D2, projid32bit=
=3D1</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0crc=3D1=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 finobt=3D0, sparse=3D0</div><div>data=C2=A0 =C2=A0 =
=C2=A0=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bsize=3D4096=C2=A0 =C2=A0blocks=3D25344, imaxpct=3D25</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sunit=3D64=C2=A0 =C2=A0=
 =C2=A0swidth=3D64 blks</div><div>naming=C2=A0 =C2=A0=3Dversion 2=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bsize=3D4096=C2=A0 =C2=A0ascii-ci=3D=
0 ftype=3D1</div><div>log=C2=A0 =C2=A0 =C2=A0 =3Dinternal log=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0bsize=3D4096=C2=A0 =C2=A0blocks=3D1728, version=
=3D2</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sectsz=3D512=
=C2=A0 =C2=A0sunit=3D64 blks, lazy-count=3D1</div><div>realtime =3Dnone=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0extsz=3D4=
096=C2=A0 =C2=A0blocks=3D0, rtextents=3D0</div><div>Warning: The kernel is =
still using the old partition table.</div><div>The new table will be used a=
t the next reboot.</div><div>The operation has completed successfully.</div=
><div>/usr/lib/python2.7/site-<wbr>packages/ceph_disk/main.py:<wbr>5685: Us=
erWarning:</div><div>******************************<wbr>*******************=
***********<wbr>*******************</div><div>This tool is now deprecated i=
n favor of ceph-volume.</div><div>It is recommended to use ceph-volume for =
OSD deployments. For details see:</div><div><br></div><div>=C2=A0 =C2=A0 <a=
 href=3D"http://docs.ceph.com/docs/master/ceph-volume/#migrating" target=3D=
"_blank">http://docs.ceph.com/docs/<wbr>master/ceph-volume/#migrating</a></=
div><div><br></div><div>******************************<wbr>****************=
**************<wbr>*******************</div><div><br></div><div>=C2=A0 warn=
ings.warn(DEPRECATION_<wbr>WARNING)</div><div>/usr/lib/python2.7/site-<wbr>=
packages/ceph_disk/main.py:<wbr>5653: UserWarning:</div><div>**************=
****************<wbr>******************************<wbr>*******************=
</div><div>This tool is now deprecated in favor of ceph-volume.</div><div>I=
t is recommended to use ceph-volume for OSD deployments. For details see:</=
div><div><br></div><div>=C2=A0 =C2=A0 <a href=3D"http://docs.ceph.com/docs/=
master/ceph-volume/#migrating" target=3D"_blank">http://docs.ceph.com/docs/=
<wbr>master/ceph-volume/#migrating</a></div><div><br></div><div>***********=
*******************<wbr>******************************<wbr>****************=
***</div><div><br></div><div>=C2=A0 warnings.warn(DEPRECATION_<wbr>WARNING)=
</div><div>got monmap epoch 3</div><div>2017-12-08 16:07:57.262854 7fe58f6e=
6d00 -1 key</div><div>2017-12-08 16:07:57.769048 7fe58f6e6d00 -1 created ob=
ject store /var/lib/ceph/tmp/mnt.dTiXMX for osd.16 fsid b2f1b9b9-eecc-4c17-=
8b92-<wbr>cfa60b31c121</div><div>Removed symlink /run/systemd/system/ceph-o=
sd.<wbr>target.wants/ceph-osd@16.<wbr>service.</div><div>Created symlink fr=
om /run/systemd/system/ceph-osd.<wbr>target.wants/ceph-osd@16.<wbr>service =
to /usr/lib/systemd/system/ceph-<wbr>osd@.service.</div><div><br></div><div=
>---</div><div><br></div><div><br></div><div>On the second occurance. , I&#=
39;m getting below issue...=C2=A0</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</div><div><br></div><div><div># ceph-disk prepare --b=
luestore --cluster ceph --cluster-uuid b2f1b9b9-eecc-4c17-8b92-<wbr>cfa60b3=
1c121 /dev/sde; ceph-disk activate /dev/sde1</div><div>/usr/lib/python2.7/s=
ite-<wbr>packages/ceph_disk/main.py:<wbr>5653: UserWarning:</div><div>*****=
*************************<wbr>******************************<wbr>**********=
*********</div><div>This tool is now deprecated in favor of ceph-volume.</d=
iv><div>It is recommended to use ceph-volume for OSD deployments. For detai=
ls see:</div><div><br></div><div>=C2=A0 =C2=A0 <a href=3D"http://docs.ceph.=
com/docs/master/ceph-volume/#migrating" target=3D"_blank">http://docs.ceph.=
com/docs/<wbr>master/ceph-volume/#migrating</a></div><div><br></div><div>**=
****************************<wbr>******************************<wbr>*******=
************</div><div><br></div><div>=C2=A0 warnings.warn(DEPRECATION_<wbr=
>WARNING)</div><div>Creating new GPT entries.</div><div>The operation has c=
ompleted successfully.</div><div>The operation has completed successfully.<=
/div><div>The operation has completed successfully.</div><div>meta-data=3D/=
dev/sde1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isize=3D2048=C2=A0=
 =C2=A0agcount=3D4, agsize=3D6336 blks</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0sectsz=3D512=C2=A0 =C2=A0attr=3D2, projid32bit=3D1</di=
v><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0crc=3D1=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 finobt=3D0, sparse=3D0</div><div>data=C2=A0 =C2=A0 =C2=A0=3D=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bsize=3D4096=C2=A0 =C2=A0blocks=3D25344, imaxpct=3D25</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sunit=3D64=C2=A0 =C2=A0 =C2=A0=
swidth=3D64 blks</div><div>naming=C2=A0 =C2=A0=3Dversion 2=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bsize=3D4096=C2=A0 =C2=A0ascii-ci=3D0 ftype=
=3D1</div><div>log=C2=A0 =C2=A0 =C2=A0 =3Dinternal log=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0bsize=3D4096=C2=A0 =C2=A0blocks=3D1728, version=3D2</di=
v><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sectsz=3D512=C2=A0 =C2=
=A0sunit=3D64 blks, lazy-count=3D1</div><div>realtime =3Dnone=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0extsz=3D4096=C2=A0 =
=C2=A0blocks=3D0, rtextents=3D0</div><div>Warning: The kernel is still usin=
g the old partition table.</div><div>The new table will be used at the next=
 reboot.</div><div>The operation has completed successfully.</div><div>/usr=
/lib/python2.7/site-<wbr>packages/ceph_disk/main.py:<wbr>5685: UserWarning:=
</div><div>******************************<wbr>*****************************=
*<wbr>*******************</div><div>This tool is now deprecated in favor of=
 ceph-volume.</div><div>It is recommended to use ceph-volume for OSD deploy=
ments. For details see:</div><div><br></div><div>=C2=A0 =C2=A0 <a href=3D"h=
ttp://docs.ceph.com/docs/master/ceph-volume/#migrating" target=3D"_blank">h=
ttp://docs.ceph.com/docs/<wbr>master/ceph-volume/#migrating</a></div><div><=
br></div><div>******************************<wbr>**************************=
****<wbr>*******************</div><div><br></div><div>=C2=A0 warnings.warn(=
DEPRECATION_<wbr>WARNING)</div><div>/usr/lib/python2.7/site-<wbr>packages/c=
eph_disk/main.py:<wbr>5653: UserWarning:</div><div>************************=
******<wbr>******************************<wbr>*******************</div><div=
>This tool is now deprecated in favor of ceph-volume.</div><div>It is recom=
mended to use ceph-volume for OSD deployments. For details see:</div><div><=
br></div><div>=C2=A0 =C2=A0 <a href=3D"http://docs.ceph.com/docs/master/cep=
h-volume/#migrating" target=3D"_blank">http://docs.ceph.com/docs/<wbr>maste=
r/ceph-volume/#migrating</a></div><div><br></div><div>*********************=
*********<wbr>******************************<wbr>*******************</div><=
div><br></div><div>=C2=A0 warnings.warn(DEPRECATION_<wbr>WARNING)</div><div=
>got monmap epoch 3</div><div>2017-12-08 16:09:07.518454 7fa64e12fd00 -1 bl=
uestore(/var/lib/ceph/tmp/<wbr>mnt.7x0kCL/block) _check_or_set_bdev_label b=
dev /var/lib/ceph/tmp/mnt.7x0kCL/<wbr>block fsid 54954cfd-b7f3-4f74-9b2e-<w=
br>2ef57c5143cc does not match our fsid 29262e99-12ff-4c45-9113-<wbr>8f6983=
0a1a5e</div><div>2017-12-08 16:09:07.772688 7fa64e12fd00 -1 bluestore(/var/=
lib/ceph/tmp/<wbr>mnt.7x0kCL) mkfs fsck found fatal error: (5) Input/output=
 error</div><div>2017-12-08 16:09:07.772723 7fa64e12fd00 -1 OSD::mkfs: Obje=
ctStore::mkfs failed with error (5) Input/output error</div><div>2017-12-08=
 16:09:07.772823 7fa64e12fd00 -1=C2=A0 ** ERROR: error creating empty objec=
t store in /var/lib/ceph/tmp/mnt.7x0kCL: (5) Input/output error</div><div>m=
ount_activate: Failed to activate</div><div>Traceback (most recent call las=
t):</div><div>=C2=A0 File &quot;/usr/sbin/ceph-disk&quot;, line 9, in &lt;m=
odule&gt;</div><div>=C2=A0 =C2=A0 load_entry_point(&#39;ceph-disk=3D=3D<wbr=
>1.0.0&#39;, &#39;console_scripts&#39;, &#39;ceph-disk&#39;)()</div><div>=
=C2=A0 File &quot;/usr/lib/python2.7/site-<wbr>packages/ceph_disk/main.py&q=
uot;, line 5736, in run</div><div>=C2=A0 =C2=A0 main(sys.argv[1:])</div><di=
v>=C2=A0 File &quot;/usr/lib/python2.7/site-<wbr>packages/ceph_disk/main.py=
&quot;, line 5682, in main</div><div>=C2=A0 =C2=A0 main_catch(args.func, ar=
gs)</div><div>=C2=A0 File &quot;/usr/lib/python2.7/site-<wbr>packages/ceph_=
disk/main.py&quot;, line 5710, in main_catch</div><div>=C2=A0 =C2=A0 func(a=
rgs)</div><div>=C2=A0 File &quot;/usr/lib/python2.7/site-<wbr>packages/ceph=
_disk/main.py&quot;, line 3761, in main_activate</div><div>=C2=A0 =C2=A0 re=
activate=3Dargs.reactivate,</div><div>=C2=A0 File &quot;/usr/lib/python2.7/=
site-<wbr>packages/ceph_disk/main.py&quot;, line 3524, in mount_activate</d=
iv><div>=C2=A0 =C2=A0 (osd_id, cluster) =3D activate(path, activate_key_tem=
plate, init)</div><div>=C2=A0 File &quot;/usr/lib/python2.7/site-<wbr>packa=
ges/ceph_disk/main.py&quot;, line 3701, in activate</div><div>=C2=A0 =C2=A0=
 keyring=3Dkeyring,</div><div>=C2=A0 File &quot;/usr/lib/python2.7/site-<wb=
r>packages/ceph_disk/main.py&quot;, line 3153, in mkfs</div><div>=C2=A0 =C2=
=A0 &#39;--setgroup&#39;, get_ceph_group(),</div><div>=C2=A0 File &quot;/us=
r/lib/python2.7/site-<wbr>packages/ceph_disk/main.py&quot;, line 570, in co=
mmand_check_call</div><div>=C2=A0 =C2=A0 return subprocess.check_call(<wbr>=
arguments)</div><div>=C2=A0 File &quot;/usr/lib64/python2.7/<wbr>subprocess=
.py&quot;, line 542, in check_call</div><div>=C2=A0 =C2=A0 raise CalledProc=
essError(retcode, cmd)</div><div>subprocess.CalledProcessError: Command &#3=
9;[&#39;/usr/bin/ceph-osd&#39;, &#39;--cluster&#39;, &#39;ceph&#39;, &#39;-=
-mkfs&#39;, &#39;-i&#39;, u&#39;16&#39;, &#39;--monmap&#39;, &#39;/var/lib/=
ceph/tmp/mnt.7x0kCL/<wbr>activate.monmap&#39;, &#39;--osd-data&#39;, &#39;/=
var/lib/ceph/tmp/mnt.7x0kCL&#39;<wbr>, &#39;--osd-uuid&#39;, u&#39;29262e99=
-12ff-4c45-9113-<wbr>8f69830a1a5e&#39;, &#39;--setuser&#39;, &#39;ceph&#39;=
, &#39;--setgroup&#39;, &#39;ceph&#39;]&#39; returned non-zero exit status =
1</div></div><div><br></div><div><br></div><div>Do you think is this a bug =
? Even I can reproducable it everytime on any osd&#39;s . On the first time=
 I can recreate OSD&#39;s without any problem. second time onwards the issu=
e happening.=C2=A0</div><div><br></div><div>Need your views on this ... ?</=
div><div><br></div><div>Thanks</div><div>Jayaram</div></div>
</blockquote></div><br></div>

--001a113db9548d8c990560095b50--

--===============2939896361570827201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2939896361570827201==--
