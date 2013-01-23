From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw
Date: Wed, 23 Jan 2013 10:00:19 -0800
Message-ID: <CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
References: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:44671 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab3AWSAU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 13:00:20 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so14220338iea.36
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 10:00:19 -0800 (PST)
In-Reply-To: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 23, 2013 at 9:56 AM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> I'm trying to configure RadosGW but actually, radosgw doesn't start.
>
> I've followed this guide:
> http://ceph.com/docs/master/radosgw/config/
>
> Apache configuration is OK and i've added the following configuration
> to my ceph.conf:
>
> [client.radosgw.gateway]
>         host = {host-name}
>         keyring = /etc/ceph/keyring.radosgw.gateway
>         rgw socket path = /tmp/radosgw.sock
>         log file = /var/log/ceph/radosgw.log
>
>
> i've copied ceph.conf to all servers, even on radosgw.
>
> Then, on radosgw node, i've run:
>
> mkdir -p /var/lib/ceph/radosgw/ceph-radosgw.gateway
> ceph-authtool --create-keyring /etc/ceph/keyring.radosgw.gateway
> chmod +r /etc/ceph/keyring.radosgw.gateway
> ceph-authtool /etc/ceph/keyring.radosgw.gateway -n
> client.radosgw.gateway --gen-key
> ceph-authtool -n client.radosgw.gateway --cap osd 'allow rwx' --cap
> mon 'allow r' /etc/ceph/keyring.radosgw.gateway
> ceph -k /etc/ceph/ceph.keyring auth add client.radosgw.gateway -i
> /etc/ceph/keyring.radosgw.gateway
>
> but after that, radosgw doesn't start:
>
> # radosgw
> radosgw: must specify 'rgw socket path' to run as a daemon
>
>
> but "rgw socket path" is already present in ceph.conf

(resending to all)

try
# radosgw -n client radosgw.gateway

Yehuda
