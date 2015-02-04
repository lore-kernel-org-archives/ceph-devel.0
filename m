From: John Spray <john.spray@redhat.com>
Subject: Re: using ceph-deploy on build after make install
Date: Wed, 4 Feb 2015 09:35:06 +0100
Message-ID: <CAGd4Wr0_G=iFFTG2BHWTUskrPbXLqupcq5FWLZ_wtkv5z_X0KA@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91555455F4@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:51561 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932924AbbBDIfI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Feb 2015 03:35:08 -0500
Received: by mail-la0-f46.google.com with SMTP id q1so274011lam.5
        for <ceph-devel@vger.kernel.org>; Wed, 04 Feb 2015 00:35:06 -0800 (PST)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91555455F4@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I suspect that your clue is "Failed to execute command:
/usr/sbin/service ceph" -- as a rule, service scripts are part of the
per-distro packaging rather than make install.

Personally, if I'm installing systemwide I always start with some
built packages, and if I need to substitute a home-built binary for
debugging then I do so by directly overwriting it in /usr/bin/.

John

On Wed, Feb 4, 2015 at 12:58 AM, Deneau, Tom <tom.deneau@amd.com> wrote:
> New to ceph building but here is my situation...
>
> I have been successfully able to build ceph starting from
>    git checkout firefly
> (also successful from git checkout master).  After building, I am able
> to run vstarth.sh from the source directory as ./vstart.sh -d -n -x
> (or with -X).  I can then do rados commands such as rados bench.
>
> I should also add that when I have installed binaries from rpms (this
> is a fedora21 aarch64 system), I have been successfully able to deploy
> a cluster using various ceph-deploy commands.
>
> Now I would like to do make install to install my built version and
> then use the installed version with my ceph-deploy commands.  In this
> case I installed ceph-deploy with pip install ceph-deploy which gives
> me 5.21.
>
> The first ceph-deploy command I use is:
>
>     ceph-deploy new myhost
>
> which seems to work fine.
>
> The next command however is
>
>      ceph-deploy mon create-initial
>
> which ends up failing with
>
> [INFO  ] Running command: /usr/sbin/service ceph -c /etc/ceph/ceph.conf start mon.hostname
> [WARNIN] The service command supports only basic LSB actions (start, stop, restart, try-rest\
> art, reload, force-reload, status). For other actions, please try to use systemctl.
> [ERROR ] RuntimeError: command returned non-zero exit status: 2
> [ERROR ] Failed to execute command: /usr/sbin/service ceph -c /etc/ceph/ceph.conf start mon.seattle-tdeneau
> [ERROR ] GenericError: Failed to create 1 monitors
>
> and even the ceph status command fails
>
> #  ceph -c ./ceph.conf status
>  -1 monclient(hunting): ERROR: missing keyring, cannot use cephx for authentication
>   0 librados: client.admin initialization error (2) No such file or directory
> Error connecting to cluster: ObjectNotFound
>
> Whereas this all worked fine when I used binaries from rpms.
> Is there some install step that I am missing?
>
> -- Tom Deneau, AMD
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
