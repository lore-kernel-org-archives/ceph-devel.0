From: Dan Mick <dmick@redhat.com>
Subject: Re: tool for applying 'ceph daemon <osd>' command to all OSDs
Date: Tue, 22 Dec 2015 15:46:22 -0800
Message-ID: <5679E0CE.7020401@redhat.com>
References: <5678E6C2.40007@redhat.com>
 <5265afb0293f4ecbb0a5506a912d943c@R01UKEXCASM222.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39646 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980AbbLVXqX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Dec 2015 18:46:23 -0500
In-Reply-To: <5265afb0293f4ecbb0a5506a912d943c@R01UKEXCASM222.r01.fujitsu.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/22/2015 12:21 AM, Igor.Podoski@ts.fujitsu.com wrote:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Dan Mick
>> Sent: Tuesday, December 22, 2015 7:00 AM
>> To: ceph-devel
>> Subject: RFC: tool for applying 'ceph daemon <osd>' command to all OSDs
>>
>> I needed something to fetch current config values from all OSDs (sorta the
>> opposite of 'injectargs --key value), so I hacked it, and then spiffed it up a bit.
>> Does this seem like something that would be useful in this form in the
>> upstream Ceph, or does anyone have any thoughts on its design or
>> structure?
>>
> 
> You could do it using socat too:

Quite true.  That opens the permissions even more, but it works.
Maintaining a couple hundred x2 processes might be a little bit of a pain..
