From: "Jianjian Huo" <j.huo@alibaba-inc.com>
Subject: Re: Ceph FileStore optimization with Intel drive and scrubbing
 optimization
Date: Fri, 30 Jun 2017 04:14:06 +0800
Message-ID: <3EFB19B4-D8E1-4BBB-8957-52494E25EDDC@alibaba-inc.com>
References: <F8851965-497D-464B-94E4-6D2F2C88476A@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-218.mail.aliyun.com ([140.205.0.218]:52944 "EHLO
        out0-218.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdF2UOd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jun 2017 16:14:33 -0400
In-Reply-To: <F8851965-497D-464B-94E4-6D2F2C88476A@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GBK?B?TElVLCBGZWk=?= <james.liu@alibaba-inc.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@newdream.net>, Mark Nelson <mnelson@redhat.com>, =?GBK?B?ssy9+Ciw2NPwKQ==?= <caijin.caij@alibaba-inc.com>

Hi Sage and Mark,

We had another test case (24 hours filestore run with journal stored in Optane drive) done, under our write intensive workloads, we saw IOPS increased by 59%, average latency reduced by 37%, but tail latency (99.99th) went up 65%. This new result is more meaningful for our production consideration.
Do you have any thoughts on why tail latency went up?

Thanks,
Jianjian

On 6/29/17, 9:20 AM, "LIU, Fei" <james.liu@alibaba-inc.com> wrote:

    Hi  All,
      Below link is the slides we presented today in Ceph weekly performance meeting regarding to Ceph Filestore optimization with Intel drive and scrubbing optimization.
    
      https://www.slideshare.net/jupiturliu/ceph-filestore-with-optane-drive-scrub-optimization
    
      Please feel free to let us know if you have any questions.
      
       Regards,
       James 
       Alibaba Storage Team 
    
    


