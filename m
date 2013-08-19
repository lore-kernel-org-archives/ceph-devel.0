From: Mostowiec Dominik <Dominik.Mostowiec-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>
Subject: Re: large memory leak on scrubbing
Date: Mon, 19 Aug 2013 11:15:09 +0200
Message-ID: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C852@MXMBON06.grupa.onet>
References: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C75B@MXMBON06.grupa.onet>
	<alpine.DEB.2.00.1308170808070.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1308170808070.1479-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
Content-Language: pl-PL
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: =?iso-8859-2?Q?Studzi=F1ski_Krzysztof?= <krzysztof.studzinski-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sydor Bohdan <Bohdan.Sydor-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Thanks for your response.
Great.

In latest cuttlefish it is also fixed I think?

We have two problems with scrubbing:
- memory leaks
- slow requests and wrongly mark osd with bucket index down (when scrubbing)

Now we decided to turn off scrubbing and trigger it on maintenance window.
I noticed that "ceph osd scrub", or "ceph osd deep-scrub" trigger scrub on =
osd but not for all PG.
It is possible to trigger scrubbing all PG on one osd?

--
Regards =

Dominik


-----Original Message-----
From: Sage Weil [mailto:sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org] =

Sent: Saturday, August 17, 2013 5:11 PM
To: Mostowiec Dominik
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; Studzi=F1ski Krz=
ysztof; Sydor Bohdan
Subject: Re: [ceph-users] large memory leak on scrubbing

Hi Dominic,

There is a bug fixed a couple of months back that fixes excessive memory co=
nsumption during scrub.  You can upgrade to the latest 'bobtail' branch.  =

See

 http://ceph.com/docs/master/install/debian/#development-testing-packages

Installing that package should clear this up.

sage


On Fri, 16 Aug 2013, Mostowiec Dominik wrote:

> Hi,
> We noticed some issues on CEPH/S3 cluster, I think it related with scrubb=
ing: large memory leaks.
> =

> Logs 09.xx: =

> https://www.dropbox.com/s/4z1fzg239j43igs/ceph-osd.4.log_09xx.tar.gz
> >From 09.30 to 09.44 (14 minutes) osd.4 proces grows up to 28G. =

> =

> I think this is something curious:
> 2013-08-16 09:43:48.801331 7f6570d2e700  0 log [WRN] : slow request =

> 32.794125 seconds old, received at 2013-08-16 09:43:16.007104: =

> osd_sub_op(unknown.0.0:0 16.113d 0//0//-1 [scrub-reserve] v 0'0 =

> snapset=3D0=3D[]:[] snapc=3D0=3D[]) v7 currently no flag points reached
> =

> We have large rgw index and a lot of large files than on this cluster.
> ceph version 0.56.6 (95a0bda7f007a33b0dc7adf4b330778fa1e5d70c)
> Setup: =

> - 12 servers x 12 OSD
> - 3 mons
> Default scrubbing settings.
> Journal and filestore settings:
>         journal aio =3D true
>         filestore flush min =3D 0
>         filestore flusher =3D false
>         filestore fiemap =3D false
>         filestore op threads =3D 4
>         filestore queue max ops =3D 4096
>         filestore queue max bytes =3D 10485760
>         filestore queue committing max bytes =3D 10485760
>         journal max write bytes =3D 10485760
>         journal queue max bytes =3D 10485760
>         ms dispatch throttle bytes =3D 10485760
>         objecter infilght op bytes =3D 10485760
> =

> Is this a known bug in this version?
> (Do you know some workaround to fix this?)
> =

> ---
> Regards
> Dominik
> =

> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> =

> =
