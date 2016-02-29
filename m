From: Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: v0.94.6 Hammer released
Date: Mon, 29 Feb 2016 06:11:29 -0500 (EST)
Message-ID: <191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
	<CABZ+qq=ZqhaL9uwobM1NZ7+AszUMqirHATLJZyRcowD1iDRsww@mail.gmail.com>
	<CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
	<EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com>
	<CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
	<FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com>
	<1456736629334.47610@croc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1456736629334.47610-b5CV0i+qpxk@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Odintsov Vladislav <VlOdintsov-b5CV0i+qpxk@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Franklin M. Siler" <me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org>, Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Can we make any kind of general procedure to make packages so that almost everyone in community build packages by themselves and reduce developers work load caused by too much requirement -;

Cheers,
Shinobu

----- Original Message -----
From: "Odintsov Vladislav" <VlOdintsov-b5CV0i+qpxk@public.gmane.org>
To: "Franklin M. Siler" <me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org>, "Xiaoxi Chen" <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ceph-users" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "Sage Weil" <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sent: Monday, February 29, 2016 6:04:02 PM
Subject: Re: [ceph-users] v0.94.6 Hammer released

Hi all,

should we build el6 packages ourself or, it's hoped that these packages would be built officially by community?

________________________________
Regards,

Vladislav Odintsov

________________________________________
From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> on behalf of Franklin M. Siler <me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org>
Sent: Friday, February 26, 2016 05:03
To: Xiaoxi Chen
Cc: Alfredo Deza; Dan van der Ster; Sage Weil; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users
Subject: Re: [ceph-users] v0.94.6 Hammer released

On Feb 25, 2016, at 1839, Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Will we build package for ubuntu 12.04 (Precise)?
> Seems it also doesnt show in the repo

The Ceph packages provided by Ubuntu are old.  However, the Ceph project publishes its own packages.

http://download.ceph.com/debian-hammer/dists/precise/

so repo lines for sources.list would be, I think:

deb http://download.ceph.com/debian-hammer/ precise main
deb-src http://download.ceph.com/debian-hammer/ precise main


Cheers,

Frank Siler
Siler Industrial Analytics
314.799.9405--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
