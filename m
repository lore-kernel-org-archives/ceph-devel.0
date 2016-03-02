From: Odintsov Vladislav <VlOdintsov-b5CV0i+qpxk@public.gmane.org>
Subject: Re: v0.94.6 Hammer released
Date: Wed, 2 Mar 2016 10:15:16 +0000
Message-ID: <1456913706999.87255@croc.ru>
References: <CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
	<EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com>
	<CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
	<FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com>
	<1456736629334.47610@croc.ru>
	<191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
	<1456745435596.21796@croc.ru>
	<CABZ+qqkD_w4xM-qNdxC_WkZbGPf+w0gHh2cgYnPF2-_0go5-SA@mail.gmail.com>
	<56D45CCC.8010608@dachary.org>
	<alpine.DEB.2.11.1602291056350.1904@cpach.fuggernut.com>,
	<20160302010625.GA10914@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20160302010625.GA10914-s239Etu9j1dPR4JQBCEnsQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

it looks very strange, that LTS release suddenly stopped support of one of OS'es in the middle of lifecycle. Especially when there are no technical problems.
How can we help community with building hammer branch officially?

________________________________
Regards,

Vladislav Odintsov

________________________________________
From: ceph-users <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org> on behalf of Chris Dunlop <chris-s239Etu9j1dPR4JQBCEnsQ@public.gmane.org>
Sent: Wednesday, March 2, 2016 04:06
To: Sage Weil
Cc: Loic Dachary; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org
Subject: Re: [ceph-users] v0.94.6 Hammer released

Hi,

The "old list of supported platforms" includes debian wheezy.
Will v0.94.6 be built for this?

Chris

On Mon, Feb 29, 2016 at 10:57:53AM -0500, Sage Weil wrote:
> The intention was to continue building stable releases (0.94.x) on the old
> list of supported platforms (which inclues 12.04 and el6).  I think it was
> just an oversight that they weren't built this time around.  I the
> overhead to doing so is just keeping a 12.04 and el6 jenkins build slave
> around.
>
> Doing this builds in the existing environment sounds much better than
> trying to pull in externally built binaries...
>
> sage
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
