From: Loic Dachary <loic@dachary.org>
Subject: Re: migrating dmcrypt keys ?
Date: Mon, 20 Feb 2017 20:56:22 +0100
Message-ID: <dd16ff32-75e9-3f58-b0cc-50a162774d0a@dachary.org>
References: <CAGbvivJVPkqdMhWuf=5Lx6DSi9UR9aYnAGtqT7K23NO31y_bPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:33629 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbdBTT43 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 14:56:29 -0500
In-Reply-To: <CAGbvivJVPkqdMhWuf=5Lx6DSi9UR9aYnAGtqT7K23NO31y_bPg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

On 02/20/2017 08:49 PM, Wyllys Ingersoll wrote:
> Is it possible to migrate a legacy (i..e pre-Jewel) osd device that
> was originally setup with dmcrypt keys in /etc/ceph/dmcrypt-keys to
> use the newer osd-lockbox scheme without having to destroy the osd and
> re-prepare it?

You can do it manually by mimicing what ceph-disk does. It would be nice to have a tool to do that.

Cheers

> 
> Thanks
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
