From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: OSD memory leaks?
Date: Wed, 13 Mar 2013 17:15:31 -0700
Message-ID: <514116A3.5070803@inktank.com>
References: <511505218.2097.1363219547568.JavaMail.root@optogenics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:57186 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630Ab3CNAQP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Mar 2013 20:16:15 -0400
Received: by mail-da0-f48.google.com with SMTP id w4so640145dam.35
        for <ceph-devel@vger.kernel.org>; Wed, 13 Mar 2013 17:16:15 -0700 (PDT)
In-Reply-To: <511505218.2097.1363219547568.JavaMail.root@optogenics.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Spano <dspano@optogenics.com>
Cc: Greg Farnum <greg@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Samuel Just <sam.just@inktank.com>, Vladislav Gorbunov <vadikgo@gmail.com>

On 03/13/2013 05:05 PM, Dave Spano wrote:
> I renamed the old one from images to images-old, and the new one from images-new to images.

This reminds me of a problem you might hit with this:

RBD clones track the parent image pool by id, so they'll continue
working after the pool is renamed. If you have any clones of the
images-old pool, they'll stop working when that pool is deleted.

To get around this, you'll need to flatten any clones whose parents are
in images-old before deleting the images-old pool.

Josh
