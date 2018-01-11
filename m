From: Sage Weil <sage@newdream.net>
Subject: Re: CSI (container storage interface)
Date: Thu, 11 Jan 2018 19:28:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801111924360.24931@piezo.novalocal>
References: <alpine.DEB.2.11.1801101842180.17779@piezo.novalocal> <B03A147C-24FA-415D-9C74-A3821725AEEE@tabbara.com> <CAD-gW=nyuuJ7GeYJPjsH5x4wPXWZbs28X1H16RidU0TOntp6gQ@mail.gmail.com> <6CCAF364-7C23-492B-A8FA-39DECEF9D009@quantum.com>
 <CAD-gW=ma1UZSQSasPvCZQypHhV6jxbFhzoVbbGQan_jdpUJpSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1720758876-1515698880=:24931"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:60513 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754530AbeAKT2I (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jan 2018 14:28:08 -0500
In-Reply-To: <CAD-gW=ma1UZSQSasPvCZQypHhV6jxbFhzoVbbGQan_jdpUJpSA@mail.gmail.com>
Content-ID: <alpine.DEB.2.11.1801111928020.24931@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Huamin Chen <hchen@redhat.com>
Cc: Steve LeonTang <Steve.LeonTang@quantum.com>, "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>, Bassam Tabbara <bassam@tabbara.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1720758876-1515698880=:24931
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1801111928021.24931@piezo.novalocal>

On Thu, 11 Jan 2018, Huamin Chen wrote:
> Hi Steve,
> 
> Let's come up with the feature list through github issues. It is also
> beneficial to get us up to speed with Rook features.

Yeah.  My hope is that ceph-csi can replace both the in-tree code and rook 
flexvolume driver by satisfying all of rook's (and others') requirements.

Thanks!
sage


> 
> Thanks
> 
> Huamin
> 
> On Thu, Jan 11, 2018 at 1:53 PM, Steve LeonTang
> <Steve.LeonTang@quantum.com> wrote:
> > Hi Huamin,
> >
> > Serguei mention that the current effort is to get ceph-csi driver to be feature compatible with the in-tree RBD plugin in K8s. However, doing this will not benefit Rook. There are lots of gaps in the current RBD implementation such as user/secret management, update of monitoring endpoints and ROX support to name a few. Which is the reason Rook explored to using a Flexvolume.
> >
> > What is the strategy of ceph-csi around also supporting Rook¢s needs?
> >
> > On 1/11/18, 10:42 AM, "Huamin Chen" <hchen@redhat.com> wrote:
> >
> >     (resending, previous reply bounced back)
> >
> >     Hi Bassam,
> >
> >     Thanks for the suggestions.
> >
> >     Having a CSI repo is a great first step. Now Serguei is putting up a
> >     prototype as PR #1. It mirrors the current k8s in tree rbd volume
> >     plugin.
> >
> >     Since the project just starts, there is no formal meetings and process
> >     management. Since not every contributor here use Ceph tracker, I
> >     propose to use github issues for issue and bug tracking, feature
> >     request, and assignment so we can track topics like krbd/nbd, cephfs
> >     and fuse.
> >
> >     On Wed, Jan 10, 2018 at 5:29 PM, Bassam Tabbara <bassam@tabbara.com> wrote:
> >     > Excellent! Excited to see this work starting.
> >     >
> >     > Could we please get a blueprint/design on ceph-csi written down and reviewed?
> >     >
> >     > There are a lot of different topics to consider here around secret management, user-mode vs. kernel, etc. that might be better sorted in a design doc vs. in PR reviews.
> >     >
> >     > (cc¢ing steve that offered to help)
> >     >
> >     >> On Jan 10, 2018, at 10:45 AM, Sage Weil <sweil@redhat.com> wrote:
> >     >>
> >     >> Development has kicked off on a CSI driver for Ceph (RBD initially; CephFS
> >     >> will follow).  See
> >     >>
> >     >>       https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fceph%2Fceph-csi&data=02%7C01%7CSteve.LeonTang%40quantum.com%7C304b1dcf913842527a4208d559230624%7C322a135f14fb4d72aede122272134ae0%7C1%7C0%7C636512929325908407&sdata=%2BbN2phVfQ5%2BQJCwGypH%2BNo4JKuH1xmbiLl99km8aYbo%3D&reserved=0
> >     >>       https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fceph%2Fceph-csi%2Fpulls&data=02%7C01%7CSteve.LeonTang%40quantum.com%7C304b1dcf913842527a4208d559230624%7C322a135f14fb4d72aede122272134ae0%7C1%7C0%7C636512929325908407&sdata=Xr9VWhIi%2FlN%2FwDAzxOZU1lj2rU%2FywD5U9dD0lHuvImg%3D&reserved=0
> >     >>
> >     >> CSI is a generic provisioning (and attachment) interface for container
> >     >> orchestration platforms, including Kubernetes and Mesos.
> >     >>
> >     >>       https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fcontainer-storage-interface%2Fspec&data=02%7C01%7CSteve.LeonTang%40quantum.com%7C304b1dcf913842527a4208d559230624%7C322a135f14fb4d72aede122272134ae0%7C1%7C0%7C636512929325908407&sdata=8KgV3ZuUX7%2BdXxJpoe2sz1INodEoNzEFVoxA7PefXeQ%3D&reserved=0
> >     >>
> >     >> In the kubernetes context, this will /eventually/ replace the in-tree RBD
> >     >> and CephFS volume drivers, as well as Rook's flex volume plugin.
> >     >>
> >     >> sage
> >     >> --
> >     >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >     >> the body of a message to majordomo@vger.kernel.org
> >     >> More majordomo info at  https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger.kernel.org%2Fmajordomo-info.html&data=02%7C01%7CSteve.LeonTang%40quantum.com%7C304b1dcf913842527a4208d559230624%7C322a135f14fb4d72aede122272134ae0%7C1%7C0%7C636512929325908407&sdata=C7mInLBxcIFneCsNgIwp9K66BoV238y8BPc9m3p4d3U%3D&reserved=0
> >     >
> >     > --
> >     > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >     > the body of a message to majordomo@vger.kernel.org
> >     > More majordomo info at  https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger.kernel.org%2Fmajordomo-info.html&data=02%7C01%7CSteve.LeonTang%40quantum.com%7C304b1dcf913842527a4208d559230624%7C322a135f14fb4d72aede122272134ae0%7C1%7C0%7C636512929325908407&sdata=C7mInLBxcIFneCsNgIwp9K66BoV238y8BPc9m3p4d3U%3D&reserved=0
> >
> >
> > The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through security software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
> 
> 
--8323329-1720758876-1515698880=:24931--
