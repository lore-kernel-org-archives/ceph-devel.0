From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Fwd: Build failed in Jenkins: ceph-master #1408
Date: Tue, 14 Nov 2017 11:04:15 +0100
Message-ID: <f08831ed-0611-704e-5280-8dfef6de6fae@digiware.nl>
References: <14085029.62.1509737256278.JavaMail.jenkins@cephdev.digiware.nl>
 <fe5aaa26-d32e-916f-2af6-91ba5a4ab11e@digiware.nl>
 <dc1cdc3e-4b95-85dd-5ccd-94fe0cbecba0@redhat.com>
 <6bfee3c0-2320-cc93-2815-429040ccac47@digiware.nl>
 <6c930c4f-d269-7185-d4ba-bb2b4b96bb69@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:51561 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753080AbdKNKEb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 14 Nov 2017 05:04:31 -0500
In-Reply-To: <6c930c4f-d269-7185-d4ba-bb2b4b96bb69@digiware.nl>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 11-11-2017 13:38, Willem Jan Withagen wrote:
> On 04/11/2017 18:40, Willem Jan Withagen wrote:
>> On 3-11-2017 22:24, Casey Bodley wrote:
>>> Hi Willem, (and cc list)
>>>
>>> I think this one is related to your boost version. In my builds, I 
>>> see that boost::beast::string_ref is typedef'd to boost::string_ref 
>>> and this builds. Your output implies that it's typedef'ed to 
>>> boost::string_view.
>>>
>>> https://github.com/boostorg/beast/commit/64ff766b2304c751e1a46d2b7ca948cd274c5739 
>>> added some preprocessor stuff that switches from one to the other 
>>> based on whether BOOST_VERSION >= 106400. You might try defining 
>>> BEAST_NO_BOOST_STRING_VIEW to work around that for now.
>>
>> That did not do it.
>> So we might need to change some of the functions-sigs and conversion 
>> is possible.
> 
> Casey,
> 
> Any chance you have a fix for Clang for this?

Thanx for fixing this.

--WjW


