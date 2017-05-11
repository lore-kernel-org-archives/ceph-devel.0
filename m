From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Re: Alibaba's work on recovery process
Date: Fri, 12 May 2017 02:14:28 +0800
Message-ID: <649B4555-BDE0-4C5C-B9A2-929BF58D3B13@alibaba-inc.com>
References: <a67e2852-8c58-aca2-cf08-f8315d00e470@corp.ovh.com>
 <017717D3-EE64-4BCB-A284-D066C32C8181@alibaba-inc.com>
 <CAE7zfpM33_7iBnoxOTq16TFh5MXmEE=xWJoTunV5=CSh24Kb+Q@mail.gmail.com>
 <F28FEF91-F57A-48FB-B673-817758BCAF58@alibaba-inc.com>
 <abe1e3d7-7659-f991-63d4-2dea5400e90a@corp.ovh.com>
 <3CF80935-8AC5-41B1-BC56-7DFB0F590172@alibaba-inc.com>
 <alpine.DEB.2.11.1705111741450.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-205.mail.aliyun.com ([140.205.0.205]:59490 "EHLO
        out0-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdEKSOy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 14:14:54 -0400
In-Reply-To: <alpine.DEB.2.11.1705111741450.18953@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Piotr =?UTF-8?B?RGHFgmVr?= <piotr.dalek@corp.ovh.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ming Lin <ming.lin@alibaba-inc.com>, =?GBK?B?0OzR072t?= <yanjiang.xyj@alibaba-inc.com>, Mark Nelson <mnelson@redhat.com>

Hi Sage,
  Great, we will clean the code with several of our bug fixes and get back to you for your help soon.
So far ,It runs well in our testing environment, we caught  several bugs regarding to xattr/omap/data dismatch. 
We pretty much fixed all of them and planning to add several new testing cases. We are still running tests aggressively in bigger cluster to see whether there is any existing issues.
If passed all of our aggressive testing bench ,we will transfer them into our production cluster for more observations.

By the way, we have built Alibaba in house Teuthology with more testing cases including hardware injection/networking failure injection/network switch error injection/Server failure injection etc. 
Hopefully , it can pass all of the test in a week and cover all of the corners.

  Regards,
  James

On 5/11/17, 10:44 AM, "Sage Weil" <sage@newdream.net> wrote:

    On Fri, 12 May 2017, LIU, Fei wrote:
    > Hi Piotr,
    >    Here you go. We just uploaded the slide into slideshare for your reference. Please feel free to let us know if you have any comments.
    > 
    >    https://www.slideshare.net/jupiturliu/ceph-recovery-improvement-v02
    > 
    >    Regards,
    >    James
    
    Hi James-
    
    This work is very promising!  Putting the write info in the log is 
    probably one of the easier pieces to tackle (and Josh is already looking a 
    variation of the async recovery).  If you have the time I'd love to 
    resurrect that PR and get it into a mergeable state.  Is there an open PR 
    with the current code?
    
    sage
    


