From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: apache/fcgi deprecation?
Date: Tue, 9 Feb 2016 00:07:20 +0100
Message-ID: <56B91FA8.8080709@suse.cz>
References: <56B42126.7090106@suse.cz>
 <CALqRxCxtJ5a0xB68kSNP7xr3qcJ-rEr=xP+ByqyusyuOWU2HgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57229 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932113AbcBHXHY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 8 Feb 2016 18:07:24 -0500
In-Reply-To: <CALqRxCxtJ5a0xB68kSNP7xr3qcJ-rEr=xP+ByqyusyuOWU2HgQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 02/08/2016 11:57 PM, Ken Dreyer wrote:
> Sure, please do it!
>
> I think it's just a matter of no one having time to remove it.

So we could remove the FastCGI dependency from the packaging, too?

> On Thu, Feb 4, 2016 at 9:12 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> I was just browsing the RGW documentation and noticed that parts of it are
>> still apache/fcgi-oriented (with no mention of civetweb) even in master.
>>
>> My impression was that civetweb is now recommended for RGW deployments as it
>> is faster. Is that true? And is there a plan to deprecate/drop apache/fcgi
>> support, or will it remain indefinitely?
>>
>> Would it be a good idea to expunge apache/fcgi from the docs and point folks
>> to civetweb instead?
>>
>> --
>> Nathan Cutler
>> Software Engineer Distributed Storage
>> SUSE LINUX, s.r.o.
>> Tel.: +420 284 084 037
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
