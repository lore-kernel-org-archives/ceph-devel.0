From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Dev Meeting followup on compression
Date: Mon, 8 Feb 2016 20:23:18 +0100
Message-ID: <CAOi1vP9tGqqMVV+GmF4ikmvLecKkT21HVFWB=0Bnc5WCwoNyYA@mail.gmail.com>
References: <56B8C37F.9050904@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33789 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbcBHTXT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 14:23:19 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so146561981wme.0
        for <ceph-devel@vger.kernel.org>; Mon, 08 Feb 2016 11:23:19 -0800 (PST)
In-Reply-To: <56B8C37F.9050904@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 8, 2016 at 5:34 PM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> Guys,
>
> let me summarize what we decided regarding compression support in Ceph
> during the Dev Meeting last week.
>
> Below are possible implementation options, their pros/cons and the
> conclusion.
>
> 1) Add compression support to RGW.
> Pros/Cons:
> + Simple
> + Reduced inter-component traffic
> - Limited to specific clients
> - Will conflict with partial read/writes if any appear
>
> Alyona Kiseleva from Mirantis (akyseleva@mirantis.com) will start
> implementing this promptly. You can ask additional questions to her via
> e-mail or during daily RGW stendups she is planning to attend regularly.
>
> 2) Add basic compression support to BlueStore. Basic = "Append only"
> functionality to be implemented. Specific "append only" hint/flag needs to
> be introduced for object creation interface.
>
> Pros/Cons:
> + Moderate complexity
> + Suits for any client/PG backend
> + Good isolation from other Ceph components
> - Limited applicability
> - additional 50-200% CPU load for the cluster since we compress each
> replica/EC shard independently
> - no inter-component traffic saving
> - recovery procedure requires decompress/recompress sequence

This is for EC pools only, right?  Can you elaborate on this bullet?

>
> Mirantis ( me specifically ) will start blueprint/POC creation for this
> promptly. I'm planning to attend daily RBD syncup regularly to inform on the
> progress.

Core standup and/or the new EC-overwrite meeting Sam is planning on
holding is probably a better place for this.

Thanks,

                Ilya
