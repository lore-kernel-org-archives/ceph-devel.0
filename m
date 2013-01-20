From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: questions on networks and hardware
Date: Sun, 20 Jan 2013 19:52:29 +0100
Message-ID: <50FC3CED.8000509@profihost.ag>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net> <50FC2682.3020601@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:44710 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3ATSwd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 13:52:33 -0500
In-Reply-To: <50FC2682.3020601@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: John Nielsen <lists@jnielsen.net>, ceph-devel@vger.kernel.org

Hi,

Am 20.01.2013 18:16, schrieb Wido den Hollander:
>> If I have "cluster network" and "public network" entries under
>> [global] or [osd], do I still need to specify "public addr" and
>> "cluster addr" for each OSD individually?
>>
> Already answered, but no. You don't need to. The OSDs will bind to the
> available IP in that network.

What happens if there are more than one IP available in that network?

Stefan
