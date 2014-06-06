From: Wido den Hollander <wido@42on.com>
Subject: Re: What the ceph do when detecting one OSD overloaded?
Date: Fri, 06 Jun 2014 10:27:54 +0200
Message-ID: <53917B8A.4000204@42on.com>
References: <CAOXjUBxhgB4L7PNdAcYhbFx8LCvW8eJ7Qj1vRbYn=aCfjGroBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:59956 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbaFFI14 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Jun 2014 04:27:56 -0400
In-Reply-To: <CAOXjUBxhgB4L7PNdAcYhbFx8LCvW8eJ7Qj1vRbYn=aCfjGroBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zou wonder <wonder.zou@gmail.com>, ceph-devel@vger.kernel.org

On 06/06/2014 10:14 AM, zou wonder wrote:
> Hi buddies,
>
>    I am doing investigation on Ceph and Swift,and I am newbie to Ceph.
>
> I am unclear to the behaviour of the Ceph when there is overload situation.
> According to the doc, when Ceph do CRUSH, if it find the OSD is overload,
> it will skip it to select the other OSD. It means if the OSD don't get
> overloaded
> the object should be put in this OSD. So how about the original on put on
> this OSD when it is not get overloaded?
> Can we read it ? When doing CRUSH , the OSD will be skip.
>

CRUSH will not take any performance characteristics into account. If a 
OSD is 100% utilized it will still be selected by CRUSH.

Keep in mind however that Block Devices are striped in 4MB chunks and 
the same happens for Objects stored via the RADOS Gateway.

> If my understanding is wrong, please correct me.
>
> Best Regards,
> zou
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
