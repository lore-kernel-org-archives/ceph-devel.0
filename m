From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Documentation and Versions
Date: Wed, 01 Aug 2012 10:12:40 -0700
Message-ID: <50196388.5020805@inktank.com>
References: <CA+jddaM3S1-H7ZsDBLu94Sd_NsEkOJJCDKSTNk47UhQ1tg7vqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60334 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab2HARMo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 13:12:44 -0400
Received: by pbbrp8 with SMTP id rp8so1375155pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Aug 2012 10:12:44 -0700 (PDT)
In-Reply-To: <CA+jddaM3S1-H7ZsDBLu94Sd_NsEkOJJCDKSTNk47UhQ1tg7vqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On 07/31/2012 03:10 PM, Mandell Degerness wrote:
> I was looking through the latest documentation on ceph.com and I
> really like some of the new ways of doing things.  What I find
> confusing, however, is the lack of documentation as to what version of
> ceph you need to be running in order to use the commands.  In
> particular, what is the required version of ceph to run the "ceph osd
> crush ..." commands?

Yeah, there should probably be versions in the docs. The 'ceph osd 
crush' commands were added in 0.46, but there are bug fixes for
'ceph osd crush set' in 0.48 and 'ceph osd crush move' in 0.49.

> Regards,
> Mandell Degerness

