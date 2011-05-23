From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: MDS crash
Date: Tue, 24 May 2011 02:52:57 +0300
Message-ID: <4DDAF359.3040707@ufm.su>
References: <4DDACFF0.5060902@ufm.su>	<Pine.LNX.4.64.1105231526470.30953@cobra.newdream.net>	<4DDAE39A.4040003@ufm.su> <Pine.LNX.4.64.1105231606440.30953@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:54412 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757896Ab1EWXw7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 May 2011 19:52:59 -0400
In-Reply-To: <Pine.LNX.4.64.1105231606440.30953@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 05/24/2011 02:08 AM, Sage Weil wrote:
> On Tue, 24 May 2011, Fyodor Ustinov wrote:
>> On 05/24/2011 01:27 AM, Sage Weil wrote:
>>> Hi Fyodor,
>>>
>>> This looks like #1104.  Will try to sort it out today, it should be a
>>> simple one.
>>>
>>> sage
>> May be need my "debug mds = 20, debug ms = 1" log?
>> But it is zipped - 26M. Need?
> If you can attach it to that bug, that'd be great.  Also, do you have a
> core file?  It's not clear from the other log which bad pointer is being
> dereferenced.
I can not attach files to this issue:
---
internal error

An error occurred on the page you were trying to access.
If you continue to experience problems please contact your redMine 
administrator for assistance.

-----

Please, use these links:

http://blog.ufm.su/core.zip
http://blog.ufm.su/mds.zip

WBR,
     Fyodor.


