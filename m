From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: v0.94.6 Hammer released
Date: Wed, 23 Mar 2016 02:05:10 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603230204180.23875@cpach.fuggernut.com>
References: <1456913706999.87255@croc.ru> <56D6CF42.7080909@dachary.org>
	<20160310000006.GA14061@onthe.net.au>
	<20160316232029.GA22451@onthe.net.au>
	<011EEA5C-6A6B-489B-AB20-6EDEE2F55AFE@ebay.com>
	<20160317014314.GA25617@onthe.net.au>
	<20160322224923.GA31017@onthe.net.au>
	<56F1D1D3.8070207@dachary.org> <20160322233932.GA32084@onthe.net.au>
	<56F1DD3A.4000902@dachary.org> <20160323001200.GA1244@onthe.net.au>
	<56F1E1D5.4080006@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1595105495-1458713113=:23875"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <56F1E1D5.4080006-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Cc: Wei-Chung Cheng <freeze.vicente.cheng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "Chen,
	Xiaoxi" <xiaoxchen-ZuctOmHWJ9c@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1595105495-1458713113=:23875
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Mar 2016, Loic Dachary wrote:
> On 23/03/2016 01:12, Chris Dunlop wrote:
> > Hi Lo=C3=AFc,
> >=20
> > On Wed, Mar 23, 2016 at 01:03:06AM +0100, Loic Dachary wrote:
> >> On 23/03/2016 00:39, Chris Dunlop wrote:
> >>> "The old OS'es" that were being supported up to v0.94.5 includes de=
bian
> >>> wheezy. It would be quite surprising and unexpected to drop support=
 for an
> >>> OS in the middle of a stable series.
> >>
> >> I'm unsure if wheezy is among the old OS'es. It predates my involvem=
ent in the stable releases effort. I know for sure el6 and 12.04 are supp=
orted for 0.94.x.=20
> >=20
> >>From http://download.ceph.com/debian-hammer/pool/main/c/ceph/
> >=20
> > ceph-common_0.94.1-1~bpo70+1_i386.deb              15-Dec-2015 15:32 =
           10217628
> > ceph-common_0.94.3-1~bpo70+1_amd64.deb             19-Oct-2015 18:54 =
            9818964
> > ceph-common_0.94.4-1~bpo70+1_amd64.deb             26-Oct-2015 20:48 =
            9868020
> > ceph-common_0.94.5-1~bpo70+1_amd64.deb             15-Dec-2015 15:32 =
            9868188
> >=20
> > That's all debian wheezy.
> >=20
> > (Huh. I'd never noticed 0.94.1 was i386 only!)
> >=20
>=20
> Indeed. Were these packages created as a lucky side effect or because=20
> there was a commitment at some point ? I'm curious to know the answer a=
s=20
> well :-)

Wheezy was part of the official supported list for hammer (and still=20
should be).  I think this was just an oversight for the last hammer=20
release, unless there is some infrastructure issues I haven't heard about=
.
There will be another hammer release before too long.

sage
--8323329-1595105495-1458713113=:23875
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-1595105495-1458713113=:23875--
