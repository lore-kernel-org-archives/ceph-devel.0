From: Daniel Friesen <lists@nadir-seen-fire.com>
Subject: Re: The Ceph wiki?
Date: Sun, 13 Feb 2011 16:44:55 -0800
Message-ID: <4D587B07.2050909@nadir-seen-fire.com>
References: <4D57DFFB.5080703@nadir-seen-fire.com> <Pine.LNX.4.64.1102131028450.27567@cobra.newdream.net>
Reply-To: daniel@nadir-seen-fire.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34805 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225Ab1BNAol (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Feb 2011 19:44:41 -0500
Received: by yxt3 with SMTP id 3so1835394yxt.19
        for <ceph-devel@vger.kernel.org>; Sun, 13 Feb 2011 16:44:40 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1102131028450.27567@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 11-02-13 10:30 AM, Sage Weil wrote:
> On Sun, 13 Feb 2011, Daniel Friesen wrote:
>> I noticed the Ceph wiki is fairly out of date, and wrought with the usual spam
>> (well, having .pdf enabled entitles a type of spam I haven't seen before).
>> Which felt a little concerning, since the wiki appears to be the primary
>> source of documentation, and Ceph looks like an active project with a lot of
>> potential.
>>
>> Could the Ceph group use my help maintaining the wiki?
> Absolutely!  Let me know what (if any) privs you need to work with it, or
> what ought to be fixed up with the configuration.
>
> sage
- Upgrading and installation of various anti-spam extensions still need 
commands to be run, so wherever it is I'll need shell access...
-- and a mysql account with allprivs on the database the wiki is on.
-- I prefer to maintain MW by checking it out from svn anyways (the 
REL1_## branches).
- I'll probably also setup the usual cron job I use (job queue in cron, 
sitemap generation, ...) so I'll need to be able to create one of those.
- I'm undecided on whether I should setup a 404 image handler since 
there aren't many images being used (a handler speeds up page loads by 
not making them dependent on the completion of thumbnail generation).

Whether you want me in the servers, or want me to host it on one of mine 
is up to you. I'm already hosting the CommonJS wiki and website.

-- 
~Daniel Friesen (Dantman, Nadir-Seen-Fire) [http://daniel.friesen.name]

