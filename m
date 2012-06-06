From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 3/4] libceph: make ceph_con_revoke() a msg operation
Date: Wed, 06 Jun 2012 06:51:47 -0500
Message-ID: <4FCF4453.4070802@inktank.com>
References: <4FCECD7F.9030002@inktank.com> <4FCECF25.2070300@inktank.com> <Pine.LNX.4.64.1206052217530.22586@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:58172 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab2FFLvn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 07:51:43 -0400
Received: by ghrr11 with SMTP id r11so5151485ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 04:51:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206052217530.22586@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 06/06/2012 12:18 AM, Sage Weil wrote:
> I'm mildly concerned that if the msg isn't on the con the upper layer 
> thinks it is it is a bug, and we might be better off keeping this arg and 
> asserting that con == msg->con...

The patch I burned myself on over the weekend actually assumed that
the msg->con was available to use by the client code.  I.e., it
assumed that it was not reset to NULL whenever the message left
the connection layer.

Making it null like that allows for some run-time verification of
things (e.g., BUG_ON(msg->con == NULL)) but those aren't strictly
necessary, so we could have msg->con hold whatever non-null value
it was last assigned.  We could even add a flag to indicate the
notion of who "owns" it if we still wanted the verification.

I'll just keep it as-is unless you have a strong preference for
another option; I'm open.

					-Alex
