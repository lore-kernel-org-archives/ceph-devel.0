From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: cfuse memory leak?
Date: Wed, 10 Aug 2011 10:44:38 -0700
Message-ID: <4E42C386.8050005@dreamhost.com>
References: <4E415FAE.3050808@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47998 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab1HJRoi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2011 13:44:38 -0400
In-Reply-To: <4E415FAE.3050808@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On 08/09/2011 09:26 AM, Fyodor Ustinov wrote:
> root@backup-ext:/etc/pure-ftpd/conf# ps v -C cfuse
> PID TTY STAT TIME MAJFL TRS DRS RSS %MEM COMMAND
> 916 ? Sl 86:35 21025 2260 1514931 645632 63.1 /usr/bin/cfuse -m
> 10.5.51.230 -r /clients /clients

Is this cfuse from the 0.32 packages? We've seen cfuse use a lot memory 
when it's not compiled with tcmalloc 
(http://tracker.newdream.net/issues/373).
