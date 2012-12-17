From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH] rbd: Add --json flag for the showmapped command
Date: Mon, 17 Dec 2012 09:35:04 -0800
Message-ID: <CAC-hyiFEg379SsSYDR-AOK33CjBZa10eDG8=PKxDoVKzNiRkgg@mail.gmail.com>
References: <50A6748C.7040303@inktank.com>
	<1355413032-18095-1-git-send-email-psomas@grnet.gr>
	<CAC-hyiF0Gga7rcML_2sk9gd+J7cR5uTTogR2crYsdSJB6O0NNQ@mail.gmail.com>
	<50CAE9F0.3020607@grnet.gr>
	<50CF5730.5060507@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40451 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab2LQRfF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 12:35:05 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so5776856iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 09:35:04 -0800 (PST)
In-Reply-To: <50CF5730.5060507@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Stratos Psomadakis <psomas@grnet.gr>, ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com

On Mon, Dec 17, 2012 at 9:32 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 12/14/2012 12:57 AM, Stratos Psomadakis wrote:
>>
>> On 12/13/2012 07:17 PM, Yehuda Sadeh wrote:
>>>
>>> On Thu, Dec 13, 2012 at 7:37 AM, Stratos Psomadakis <psomas@grnet.gr>
>>> wrote:
>>>>
>>>> Signed-off-by: Stratos Psomadakis <psomas@grnet.gr>
>>>> ---
>>>> Hi Josh,
>>>>
>>>> This patch adds the '--json' flag to enable dumping the showmapped
>>>> output in
>>>
>>> I think that it should be "--format=json" rather than --json. This
>>> will make it more in line with other tools. Also, then you could have
>>> the unpopular --format=xml.
>>
>>
>> Hi,
>>
>> the problem is that --format is arleady used in rbd (to select the rbd
>> image format). So, you could either use --output-format= for
>> plain/json/xml output (but then you would be inconsistent wrt the other
>> tools), or change --format to --image-format (or something like that),
>> and use --format to select the output formatting.
>
>
> We could deprecate --format in favor of --image-format, but maintain
> backwards compatibility by accepting the string 1 or 2 for --format
> still. Maybe not pretty, but it lets us be consistent without changing
> existing usage.
>
That would work, but we should dump a noticeable warning whenever it's
being used.
