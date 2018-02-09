From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Build failed in Jenkins: ceph-master #1762
Date: Sat, 10 Feb 2018 00:11:00 +0100
Message-ID: <509ecf2b-fdae-9f43-9ec0-0aea993f75d5@digiware.nl>
References: <333349266.59.1518165404718.JavaMail.jenkins@cephdev.digiware.nl>
 <36698607-d1d7-fe7d-c887-a7190b548791@digiware.nl>
 <CAJ4mKGbpTJWwwc1=JH_jvDxyQSyaW2BhQBR=TVo9pQEVKdrASA@mail.gmail.com>
 <CAJ4mKGYdiuQKSEvFbcwtVict7y5amaS1OBy9rNKVGfeFv5b0eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:56952 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753073AbeBIXLC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:11:02 -0500
In-Reply-To: <CAJ4mKGYdiuQKSEvFbcwtVict7y5amaS1OBy9rNKVGfeFv5b0eQ@mail.gmail.com>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 09/02/2018 23:43, Gregory Farnum wrote:
> Oh, I see now that Adam did this: https://github.com/ceph/ceph/pull/20392

I tried a inode_t bar = inode_t();
And that made Clang happy as well, but I'm not sure that that would not 
interfere with the sort of tests you were running.

But it is more or less equivalent to Adam's code I guess.

--WjW


> On Fri, Feb 9, 2018 at 2:40 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> On Fri, Feb 9, 2018 at 12:54 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Hi Greg,
>>>
>>> Clang is rather picky on not initing foo and bar...
>>> Suggestion for fixing this?
>> <snip>
>>
>>> /home/jenkins/workspace/ceph-master/src/test/fs/mds_types.cc:24:11: error:
>>> declaration of variable 'bar' with deduced type 'inode_t' requires an
>>> initializer
>>>    inode_t bar;
>>
>> I don't really get what it's asking for. It's talking about "deduced"
>> types, but this code isn't relying on "auto" and indeed the line clang
>> points to is declaring the type explicitly. And inode_t has a single
>> constructor that doesn't take any parameters. Googling is not leading
>> me to anything helpful either. I get the idea maybe the environment
>> isn't configured quite right, but I'm not sure how...
>> You could try sticking some parens in and see if that changes
>> anything, but random mutations like that are the only thing I can come
>> up with. :/
>> -Greg

