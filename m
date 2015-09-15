From: Gregory Farnum <gfarnum@redhat.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IDIgcmVwbGljYXRpb25zLGZsYXBwaW5nIA==?=
	=?UTF-8?B?Y2FuIG5vdCBzdG9wIGZvciBhIHZlcnkgbG9uZyB0aW1l?=
Date: Tue, 15 Sep 2015 08:33:48 -0700
Message-ID: <CAJ4mKGabZpORxraVWE69-mhm_ZnqWzWZJziQyovupnUN-c--Ow@mail.gmail.com>
References: <1CB94550540AE44E9CAAE8CD5AF40BF846CEB60D@H3CMLB12-EX.srv.huawei-3com.com>
	<CABAwU-bw_65HXAxNCVMkmCXZw4c5F0UBNwNUQwf9wOXbCt=VeA@mail.gmail.com>
	<1CB94550540AE44E9CAAE8CD5AF40BF846CEB6A5@H3CMLB12-EX.srv.huawei-3com.com>
	<CABAwU-YFhMbrvT7ao6c605aJXi2kLiC7wjr3eSAQvAqrNNzCmg@mail.gmail.com>
	<6F3FA899187F0043BA1827A69DA2F7CC0361EE09@shsmsx102.ccr.corp.intel.com>
	<1CB94550540AE44E9CAAE8CD5AF40BF846CEC8F1@H3CMLB12-EX.srv.huawei-3com.com>
	<CAJ4mKGY7p+vDmSaPa5=WjbMHT4XXNK8a9RT19R6ir=A7SvsmRQ@mail.gmail.com>
	<1CB94550540AE44E9CAAE8CD5AF40BF846CEDB54@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36732 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbbIOPdt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 11:33:49 -0400
Received: by wicgb1 with SMTP id gb1so34339214wic.1
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 08:33:48 -0700 (PDT)
In-Reply-To: <1CB94550540AE44E9CAAE8CD5AF40BF846CEDB54@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "zhao.mingyue@h3c.com" <zhao.mingyue@h3c.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, huang jun <hjwsm1989@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Sep 14, 2015 at 7:56 PM, zhao.mingyue@h3c.com
<zhao.mingyue@h3c.com> wrote:
> The OSD is supposed to stay down if any of the networks are missing.
> ----------------osd1 osd2 osd3,if cut off osd2's cluster-network,then=
 all of the osd( osd1/osd2/osd3) will all stay down?

No, but osd2 should stay down. If we've failed with this (...again...)
it'll need fixing.

> Ceph is a CP system in CAP parlance; there's no such thing as a CA sy=
stem. ;)
>
> What version of Ceph are you testing right now?-------------- ceph ve=
rsion=EF=BC=9A0.94.2
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
