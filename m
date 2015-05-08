From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Subject: RE: libcrush.so
Date: Fri, 8 May 2015 18:13:53 +0000
Message-ID: <99767EA2E27DD44DB4E9F9B9ACA458C03B313F99@SSIEXCH-MB3.ssi.samsung.com>
References: <06681238D8946F44A60AA400760A1CBF01F60F19@SHSMSX104.ccr.corp.intel.com>
 <99767EA2E27DD44DB4E9F9B9ACA458C03B313F2B@SSIEXCH-MB3.ssi.samsung.com>
 <554CF90C.8050404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:56922 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbbEHSN4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 14:13:56 -0400
In-Reply-To: <554CF90C.8050404@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, "Zhou, Yuan" <yuan.zhou@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: "Cohen, David E" <david.e.cohen@intel.com>, "Yu, Zhidong" <zhidong.yu@intel.com>

Good to know. thanks

-----Original Message-----
From: Mark Nelson [mailto:mnelson@redhat.com] 
Sent: Friday, May 08, 2015 10:58 AM
To: James (Fei) Liu-SSI; Zhou, Yuan; Ceph Development
Cc: Cohen, David E; Yu, Zhidong
Subject: Re: libcrush.so

FWIW, an easily buildable libcrush would be fantastic for simulation purposes (and things like avalanche analysis!) as well.

Mark

On 05/08/2015 12:40 PM, James (Fei) Liu-SSI wrote:
> Hi Yuan,
>     Very interesting. Would be possible to know why application needs to access the cursh map directly instead of accessing through ceph tool?
>
>    Regards,
>    James
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org 
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Zhou, Yuan
> Sent: Thursday, May 07, 2015 6:29 PM
> To: Ceph Development
> Cc: Cohen, David E; Yu, Zhidong
> Subject: libcrush.so
>
> Ceph use crush algorithm to provide the mapping of objects to OSD servers. This is great for clients so they could talk to with these OSDs directly. However there are some scenarios where the application needs to access the crush map, for load-balancing as an example.
>
> Currently Ceph doesn't provides any API to render the layout. If your application needs to access the crush map you'll going to rely on the command 'ceph osd map pool_name obj_name'. With this libcrush.so we could let the application to choose which nodes to access. The other advantage is we could provide some other bindings(python, go) based on this also.
>
>  From the git log we find libcrush was there before but removed out since Argonaut. Can anyone kindly share us the background of this change?
>
>
> Thanks, -yuan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>
