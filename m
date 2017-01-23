From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Restricting RADOS gateway users to specific IP subnets
Date: Mon, 23 Jan 2017 18:19:16 +0200
Message-ID: <CABo9giTVDxfbpXin+0mJqa4r57ekZXH-tKsm1TdRnt_pHB=1aA@mail.gmail.com>
References: <992031594.7878.1485183845229@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wj0-f181.google.com ([209.85.210.181]:34300 "EHLO
        mail-wj0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdAWQTS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 11:19:18 -0500
Received: by mail-wj0-f181.google.com with SMTP id uo9so580709wjc.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 08:19:17 -0800 (PST)
In-Reply-To: <992031594.7878.1485183845229@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jan 23, 2017 at 5:04 PM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> At Amazon you can set Bucket Policies [0] on a bucket where you can restrict request to be done from specific IP addresses and/or subnets.
>
> These policies are currently not supported by RGW, but that's not the use-case I'm looking for.
>
> The use-case here is that when a Access/Secret key pair is stolen one can access all data from that user. With the Access/Secret key pair you can also update the bucket policies and still access all the data.
>
> I'm thinking of a way where a IP ACL can be set for a user. All requests for that user will be matched to that ACL. That way, even if you steal the keys you still can't access the data.
>
> The system in this case is connected to the internet, so a firewall in between won't help since it needs to allow traffic from all places, but just specific users and their data need to be isolated.
>
> Does it sound sane if we have such a feature for the RGW? The JSON output from user info might look like:
>
> {
>   "user_id": "example",
>   "user_ip_acl" {
>     "allow" [
>       "192.168.0.0/24",
>       "2001:db8::/64
>     ]
>   }
> }
>

This is possible but it is not a small change to the user and
authentication mechanism which are being reworked at the moment.
Cannot this be done by configuring the network?

Orit

> Wido
>
> [0]: http://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
