From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Cinder doesn't work with the current rados python bindings
Date: Wed, 14 Dec 2016 09:19:43 -0500
Message-ID: <CA+aFP1CBGsqJNsXUJrZrDkDsiT3EJSHgjNfJTTw_uLZJaG7-7w@mail.gmail.com>
References: <CA+hcxJS_wKucTUetNxPrHTn2j0V6vDUjCwKUTxp176xoCmSmVw@mail.gmail.com>
 <CA+aFP1Bz_=HPVnJTJa29NJMmvzX7_gSA3EEB2n5VZLctBU4tKA@mail.gmail.com>
 <CA+hcxJTBWk0VXYBdL7zLxWJTU6VfrT8RWL7W3e53ycHYUwqXyQ@mail.gmail.com>
 <CA+aFP1BnR-U_gFAR8zbgh3AnEk-SaLU1ucDA9AD5gu-t_UwxnA@mail.gmail.com>
 <20161214094429.GA8416@gmail.com> <CA+aFP1DesvY2=+0yVyNwpAcLZTq44QEFKgyXc5vHvWpi-i9wFw@mail.gmail.com>
 <20161214141251.GB8416@gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35766 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755436AbcLNOTt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2016 09:19:49 -0500
Received: by mail-qt0-f175.google.com with SMTP id c47so24333128qtc.2
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2016 06:19:44 -0800 (PST)
In-Reply-To: <20161214141251.GB8416@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Victor Denisov <vdenisov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

I see option (3) as such a large restriction on one of largest (if not
the largest) end-users of librbd that it's effectively a vote for just
reverting the change.

In answer to your other question, yes, Cinder/Nova/Glance will all be
happy w/ a string integer since that is exactly what they were getting
before (the librados API only provides string representations for
config values).

On Wed, Dec 14, 2016 at 9:12 AM, Mykola Golub <mgolub@mirantis.com> wrote:
> On Wed, Dec 14, 2016 at 08:39:03AM -0500, Jason Dillaman wrote:
>> In the short and medium term, there isn't any way to get multiple
>> versions of OpenStack to stop directly parsing librbd configuration
>> options and switch to new API methods. The only reason they are
>> overriding the default image features is to ensure layering support is
>> enabled. In the C/C++ APIs, we have a clean way [1] to add individual
>> features while keeping the default feature set, but this isn't
>> currently exposed in the Python API.
>>
>> For the Kraken release, I think the only two real options are to (1)
>> add internal support for a config validator that takes the human
>> friendly, comma delimited feature names and automatically converts
>> them to the integer that has previously been expected, or (2) revert
>> the change and go back to using a non-user friendly bitmask.
>
> (3) Hardcode rbd_default_features in common/config_opts.h to its
> numerical value (currently it should work both way). It would make
> cinder (and other users who parse rbd_default_features) happy until it
> is explicitly set in the config using a new way (as a list of feature
> names). Document this restriction -- cinder users who want to change
> rbd_default_features in ceph.conf would need to continue to use a
> numeric value.
>
> This may be used as workaround on currently affected installations.
> Victor, could you please try to set rbd_default_features in ceph.conf
> to its numeric value (61) and see if it fixes the issue?
>
> --
> Mykola Golub



-- 
Jason
