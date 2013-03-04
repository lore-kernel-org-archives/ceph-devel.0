From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: rename object
Date: Sun, 3 Mar 2013 18:57:59 -0800
Message-ID: <CAC-hyiFNC-DDhZbO6q5GbHqd3b8Wwg7-dbNErzfagpMwHC_+5w@mail.gmail.com>
References: <loom.20130304T033814-431@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:46198 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962Ab3CDC6A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Mar 2013 21:58:00 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so5657023ieb.34
        for <ceph-devel@vger.kernel.org>; Sun, 03 Mar 2013 18:57:59 -0800 (PST)
In-Reply-To: <loom.20130304T033814-431@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Hume <andrew@research.att.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Mar 3, 2013 at 6:41 PM, Andrew Hume <andrew@research.att.com> wrote:
> i want to rename an object (at the RADOS level).
> i see no API for that, although the gateway API has a copy object.
>
> is there any (efficient) way to rename an object?
>

Objects location is determined by their names (with one unrelated
exception). Therefore, you can't atomically do a rename operation, as
they would most likely need to be relocated to a different placement
group.

Yehuda
