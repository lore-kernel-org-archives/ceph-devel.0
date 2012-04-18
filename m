From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Log files with 0.45
Date: Tue, 17 Apr 2012 22:09:38 -0700
Message-ID: <4A32F0EAF810462DA627FE3E06945B65@dreamhost.com>
References: <4F8E48C3.7040309@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42229 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab2DRFJm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 01:09:42 -0400
Received: by obbta14 with SMTP id ta14so6121920obb.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Apr 2012 22:09:42 -0700 (PDT)
In-Reply-To: <4F8E48C3.7040309@bisect.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>, Samuel Just <samuel.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, Danny Kukawka <dkukawka@suse.de>

On Tuesday, April 17, 2012 at 9:53 PM, Danny Kukawka wrote:
> Hi,
> 
> did something change with the default log levels for OSDs on v0.45? With
> 0.43 and IIRC also 0.44* the logfiles had a acceptable size, but now I
> get by default ~3Gbyte per OSD over 12 hours without any change in the
> config file.
> 
> Danny 
I think some extra event notifications got stuck in the logs for OSD operations; they're nice for debugging but may well have a log level higher than they should. They should be easy to compress a lot, though!

Can you comment on this, Sam? 
-Greg

