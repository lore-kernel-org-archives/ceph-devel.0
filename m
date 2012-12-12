From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Crush and Monitor questions
Date: Wed, 12 Dec 2012 17:37:37 +0000
Message-ID: <50C8C0E1.6060909@inktank.com>
References: <ka84oo$sa3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35341 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab2LLRhy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 12:37:54 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so538280bkw.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 09:37:52 -0800 (PST)
In-Reply-To: <ka84oo$sa3$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bryant Ng <bryantng@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hello Bryant,

On 12/11/2012 08:23 PM, Bryant Ng wrote:
> Hi,
>
> I'm pretty new to Ceph and am just learning about it.
>
> Where are the CRUSH maps stored in Ceph? In the documentation I see you
> use the 'crushtool' to compile and decompile the crush map.

The crushmap is kept alongside with the osdmap, and shared by the monitors.

> I understand that if a single monitor comes online, it can talk to the
> other existing monitors to get the cluster map but how does it work on
> initial startup?  Or if the entire Ceph clusters goes down b/c of power
> failure or something.

If you add a new monitor to an existing cluster, it will synchronize 
with the existing monitors and will obtain all their infos, including 
the crushmap. Updates to the crushmap will also be shared among the 
monitors in the quorum.

If you are starting up fresh, you will have to either add your custom 
crushmap to the monitors (using the ceph tool), or stick with the 
default crushmap (which only defines something along the lines of a 
'default' root, a 'defaultrack' rack and a 'localhost' host).

If the entire cluster goes down... well, if the monitors are not up they 
won't be able to share the crushmap. When they are brought back up, then 
they will pick up where they left. But I'm not sure if I understand what 
your question is.

   -Joao
