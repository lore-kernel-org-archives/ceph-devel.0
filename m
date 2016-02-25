From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Building packages from a SHA instead of the tip of a branch
Date: Thu, 25 Feb 2016 09:37:25 -0800
Message-ID: <CAJ4mKGbR-PnAztnEYzPjjyOS9gbh5EHBrx8Y=iZQTTugf=TS_A@mail.gmail.com>
References: <56CEF369.7020403@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33963 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381AbcBYRh1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 12:37:27 -0500
Received: by mail-vk0-f41.google.com with SMTP id e185so54377866vkb.1
        for <ceph-devel@vger.kernel.org>; Thu, 25 Feb 2016 09:37:26 -0800 (PST)
In-Reply-To: <56CEF369.7020403@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Gregory Meno <gmeno@redhat.com>, Alfredo Deza <adeza@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Feb 25, 2016 at 4:28 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Gregory and Alfredo,
>
> The system in place to build packages uses the tip of the stable branch, which has been a recurring problem over the past years. It would make a lot of sense to use a specific SHA1 instead of "whatever is at the tip of the stable branch at the moment".
>
> Is there already an issue in tracker.ceph.com for this ? If not, in which tracker do you suggest I file this feature request ?

It might be easier to build from a tag or to push a specifically-named
branch (infernalis-release-2016-02-25) as well. Just to think around
the problem. ;)
-Greg
