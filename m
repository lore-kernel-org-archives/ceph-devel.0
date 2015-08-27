From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: Errors attaching RBD image to a running VM
Date: Thu, 27 Aug 2015 08:30:22 -0400 (EDT)
Message-ID: <1799199753.9411791.1440678622013.JavaMail.zimbra@redhat.com>
References: <20121207212247.GA12635@staff.dca.net> <50C6504D.8090307@inktank.com> <20121210232935.GD22300@staff.dca.net> <loom.20150825T132950-136@post.gmane.org> <CAFdRU73roiZmHu60ELVCFnV0M=WcPzk7Af1r1zSqiWSZE7yQEg@mail.gmail.com> <85E6A9CA58484A42B4C2F91092BC19870849102F@G9W0733.americas.hpqcorp.net> <84670482.8877337.1440591821445.JavaMail.zimbra@redhat.com> <85E6A9CA58484A42B4C2F91092BC198708499E61@G4W3228.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:52715 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbbH0MaY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Aug 2015 08:30:24 -0400
In-Reply-To: <85E6A9CA58484A42B4C2F91092BC198708499E61@G4W3228.americas.hpqcorp.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "B, Naga Venkata" <naga.b@hpe.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hello,

My question from first look at is that, is it your environment?

> Currently running SL 6.3, OpenStack Folsom packages from EPEL, Libvirt 0.9.10,
> QEMU 1.2.1 built from an epel-testing SRPM for RBD support, and Ceph 0.54

If it's true, you have to upgrade SL and Ceph as much as you can.
Because, as you might notice, there have been a bunch of bug fixes.

And please attach logs related to Ceph, qemu and livbirt.

Shinobu

----- Original Message -----
From: "B, Naga Venkata" <naga.b@hpe.com>
To: "Shinobu Kinjo" <skinjo@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Thursday, August 27, 2015 7:12:36 PM
Subject: RE: Errors attaching RBD image to a running VM

Hi Shinobu,

Can I have quick reply on this, is this issue with libvirt version or ceph.

Thanks & Regards,
Venkat

-----Original Message-----
From: Shinobu Kinjo [mailto:skinjo@redhat.com] 
Sent: Wednesday, August 26, 2015 5:54 PM
To: B, Naga Venkata
Cc: Ceph Development
Subject: Re: Errors attaching RBD image to a running VM

Hello Venkat,

Thank you!!

 Shinobu

----- Original Message -----
From: "B, Naga Venkata" <naga.b@hpe.com>
To: skinjo@redhat.com
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Wednesday, August 26, 2015 7:24:17 PM
Subject: RE: Errors attaching RBD image to a running VM

Hi Shinobu,

This is from http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/11230.

Thanks & Regards,
Venkat


From: Shinobu [mailto:shinobu.kj@gmail.com]
Sent: Tuesday, August 25, 2015 5:35 PM
To: B, Naga Venkata
Cc: Ceph Development
Subject: Re: Errors attaching RBD image to a running VM

Where is original message?
Shinobu

On Tue, Aug 25, 2015 at 8:31 PM, venkat <naga.b@hp.com<mailto:naga.b@hp.com>> wrote:



same issue with libvirt version 1.2.9,
can somebody help me.

Thanks & Regards,
Venkat

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org<mailto:majordomo@vger.kernel.org>
More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Email:
 shinobu@linux.com<mailto:shinobu@linux.com>
 skinjo@redhat.com<mailto:skinjo@redhat.com>

 Life w/ Linux<http://i-shinobu.hatenablog.com/>
