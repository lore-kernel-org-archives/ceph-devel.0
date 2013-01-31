From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Paxos and long-lasting deleted data
Date: Thu, 31 Jan 2013 21:50:52 +0300
Message-ID: <CABYiri82rCvVD79rnhm3mFPoegnF7w4SNyUrFr+axEoty69n1A@mail.gmail.com>
References: <CABYiri8fbbpuhh0RguqdsmYEbEkYz_+PKO4UJqWqKb1TwDcc6A@mail.gmail.com>
 <CAPYLRzjwn4LxnzbX9SBJL7x7AtX6=pmv84HXBGykNGHn7zVLTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59514 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab3AaSvN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 13:51:13 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so3253051obc.33
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 10:51:12 -0800 (PST)
In-Reply-To: <CAPYLRzjwn4LxnzbX9SBJL7x7AtX6=pmv84HXBGykNGHn7zVLTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Joao Eduardo Luis <joao.luis@inktank.com>

http://xdel.ru/downloads/ceph-log/rados-out.txt.gz


On Thu, Jan 31, 2013 at 10:31 PM, Gregory Farnum <greg@inktank.com> wrote:
> Can you pastebin the output of "rados -p rbd ls"?
>
> On Thu, Jan 31, 2013 at 10:17 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> Hi,
>>
>> Please take a look, this data remains for days and seems not to be
>> deleted in future too:
>>
>> pool name       category                 KB      objects       clones
>>    degraded      unfound           rd        rd KB           wr
>> wr KB
>> data            -                          0            0            0
>>            0           0            0            0            0
>>     0
>> install         -                   15736833         3856            0
>>            0           0           16            3       464648
>> 60970390
>> metadata        -                          0            0            0
>>            0           0            0            0            0
>>     0
>> prod-rack0      -                  364027905        88895            0
>>            0           0           32            0       267626
>> 689034186
>> rbd             -                    4194305         1027            0
>>            0           0            4            1        11269
>> 25165828
>>   total used      6900914368        93778
>>   total avail    18335469376
>>   total space    25236383744
>>
>> for pool in $(rados lspools) ; do rbd ls -l $pool ; done | grep -v
>> SIZE | awk '{ sum += $2} END { print sum }'
>> rbd: pool data doesn't contain rbd images
>> rbd: pool metadata doesn't contain rbd images
>> 526360
>>
>> I have same thing before, but not so contrast as there. Cluster was
>> put on moderate failure test, dropping one or two osds at once under
>> I/O pressure with replication factor three.

>Just wondering if there was something else you wanted to discuss on your email given the email subject. Wanted by any >chance discuss anything regarding Paxos?

Sorry, please nevermind, just thought about paxos-like behavior and
suddenly put that in a title, instead of ``osd data placement''.

>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
