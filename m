From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw multi-tenancy and bucket linking
Date: Thu, 15 Dec 2016 09:20:10 -0800
Message-ID: <CADRKj5TdhR2bOJnfYh53i5qb=BvDE5b4v-KxKMj7oh_z+-YTzA@mail.gmail.com>
References: <156DAD87-C02D-4D65-BD05-FB17C60B8407@walmartlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36679 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbcLORU1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2016 12:20:27 -0500
Received: by mail-vk0-f49.google.com with SMTP id p9so75031147vkd.3
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2016 09:20:11 -0800 (PST)
In-Reply-To: <156DAD87-C02D-4D65-BD05-FB17C60B8407@walmartlabs.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Dec 15, 2016 at 3:20 AM, Pavan Rallabhandi
<PRallabhandi@walmartlabs.com> wrote:
> I realize from code that bucket linking doesn’t seem to be supported across tenants. Was that intentional, and if so was that because buckets need not be unique across tenants?
>
> Couldn’t get any insights from the archives on this, any help is appreciated.
>

This was intentional as we wanted to keep it simple. There are some
data structures (e.g., bucket instance info?) that the tenant makes
part of their key, so moving it to a different tenant means we'd need
to rewrite these. Also you'd need to go through all the objects on the
bucket and amend their acls to match the new tenant. So it'd need some
conversion process.

Yehuda
