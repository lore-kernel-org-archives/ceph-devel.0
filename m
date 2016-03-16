From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: v10.0.4 released
Date: Wed, 16 Mar 2016 10:06:28 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603161005180.14377@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1603081634450.14358@cpach.fuggernut.com>
	<56E95C3C.7080907@dachary.org>
	<CA+9C14bozVMjVS+Z7hp+iqduJWgTwa7gt-vhB7cGBmKC_ORjYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1287619116-1458137191=:14377"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+9C14bozVMjVS+Z7hp+iqduJWgTwa7gt-vhB7cGBmKC_ORjYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Eric Eastman <eric.eastman-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org>
Cc: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1287619116-1458137191=:14377
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Mar 2016, Eric Eastman wrote:
> Thank you for doing this.=C2=A0 It will make testing 10.0.x easier for =
all of us
> in the field, and will make it easier to report bugs, as we will know t=
hat
> the problems we find were not caused by our build process.=C2=A0

Note that you can also always pull builds from the gitbuilders (which is=20
what we run QA against).  Both of these should work:

 ceph-deploy install --dev jewel HOST
 ceph-deploy install --dev v10.0.5 HOST

or you can grab builds directly from gitbuilder.ceph.com.

sage



> Eric
>=20
> On Wed, Mar 16, 2016 at 7:14 AM, Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org> wrote:
>       Hi,
>=20
>       Because of a tiny mistake preventing deb packages to be built,
>       v10.0.5 was released shortly after v10.0.4 and is now the
>       current development release. The Stable release team[0]
>       collectively decided to help by publishing development
>       packages[1], starting with v10.0.5.
>=20
>       The packages for v10.0.5 are available at
>       http://ceph-releases.dachary.org/ which can be used as a
>       replacement for http://download.ceph.com/ for both
>       http://download.ceph.com/rpm-testing and
>       http://download.ceph.com/debian-testing . The only difference is
>       the key used to sign the releases which can be imported with
>=20
>       =C2=A0 =C2=A0 wget -q -O-
>       'http://ceph-releases.dachary.org/release-key.asc' | sudo
>       apt-key add -
>=20
>       or
>=20
>       =C2=A0 =C2=A0 rpm --import
>       http://ceph-releases.dachary.org/release-key.asc
>=20
>       The instructions to install development packages found at
>       http://docs.ceph.com/docs/master/install/get-packages/ can
>       otherwise be applied with no change.
>=20
>       Cheers
>=20
>       [0] Stable release team
>       http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO#Whos-wh=
o
>       [1] Publishing development releases
>       http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/3012=
6
>=20
>       On 08/03/2016 22:35, Sage Weil wrote:
>       > This is the fourth and last development release before Jewel.
>       The next
>       > release will be a release candidate with the final set of
>       features. Big
>       > items include RGW static website support, librbd journal
>       framework, fixed
>       > mon sync of config-key data, C++11 updates, and
>       bluestore/kstore.
>       >
>       > Note that, due to general developer busyness, we aren=E2=80=99t
>       building official
>       > release packages for this dev release. You can fetch autobuilt
>       gitbuilder
>       > packages from the usual location (http://gitbuilder.ceph.com).
>       >
>       > Notable Changes
>       > ---------------
>       >
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://ceph.com/releases/v10-0=
-4-released/
>       >
>       > Getting Ceph
>       > ------------
>       >
>       > * Git at git://github.com/ceph/ceph.git
>       > * For packages, see
>       http://ceph.com/docs/master/install/get-packages#add-ceph-develop=
ment
>       > * For ceph-deploy, see
>       http://ceph.com/docs/master/install/install-ceph-deploy
>       >
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
>=20
>=20
>=20
--8323329-1287619116-1458137191=:14377
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-1287619116-1458137191=:14377--
