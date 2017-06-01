From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Alibaba's work on async transaction
Date: Fri, 02 Jun 2017 05:31:04 +0800
Message-ID: <C00F39E2-837F-4995-A7D8-1FD100C59E48@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-205.mail.aliyun.com ([140.205.0.205]:46112 "EHLO
        out0-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFAVb1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 17:31:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>
Cc: Sheng Qiu <sheng.qiu@alibaba-inc.com>

Hi Sage, 
   Here is the slides that I mentioned in morning conference call regarding to async transaction implementation in the backend blustore

  https://www.slideshare.net/jupiturliu/async-queuetransaction

  We will modify the PR accordingly with your advice last time.

  Thanks,
  James

On 5/18/17, 5:50 PM, "LIU, Fei" <ceph-devel-owner@vger.kernel.org on behalf of james.liu@alibaba-inc.com> wrote:

    Hi Lin and Brett,
       Out of town for business trip. Got a little bit of problem to access slideshare out of US. Will send you the link soon after I am back to town.
    
      thanks,
      James
    
    On 5/19/17, 12:16 AM, "Ning Yao" <ceph-devel-owner@vger.kernel.org on behalf of zay11022@gmail.com> wrote:
    
        It is a private slide
        Regards
        Ning Yao
        
        
        2017-05-12 0:41 GMT+08:00 LIU, Fei <james.liu@alibaba-inc.com>:
        > Hi All,
        >   Here is the slides that we presented this morning regarding to IO returning once we get majority commit.  Please feel free to send us any comments and questions.
        >
        >   https://www.slideshare.net/jupiturliu/ceph-majority-commit
        >
        >   Regards,
        >   James
        >
        >
        >
        > --
        > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
        > the body of a message to majordomo@vger.kernel.org
        > More majordomo info at  http://vger.kernel.org/majordomo-info.html
        --
        To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
        the body of a message to majordomo@vger.kernel.org
        More majordomo info at  http://vger.kernel.org/majordomo-info.html
        
    
    
    --
    To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
    the body of a message to majordomo@vger.kernel.org
    More majordomo info at  http://vger.kernel.org/majordomo-info.html
    


