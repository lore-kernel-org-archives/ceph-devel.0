From: Wido den Hollander <wido@42on.com>
Subject: Restricting RADOS gateway users to specific IP subnets
Date: Mon, 23 Jan 2017 16:04:05 +0100 (CET)
Message-ID: <992031594.7878.1485183845229@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:49851 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdAWPFW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 10:05:22 -0500
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
        by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 231EA3FCE1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 16:04:05 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

At Amazon you can set Bucket Policies [0] on a bucket where you can restrict request to be done from specific IP addresses and/or subnets.

These policies are currently not supported by RGW, but that's not the use-case I'm looking for.

The use-case here is that when a Access/Secret key pair is stolen one can access all data from that user. With the Access/Secret key pair you can also update the bucket policies and still access all the data.

I'm thinking of a way where a IP ACL can be set for a user. All requests for that user will be matched to that ACL. That way, even if you steal the keys you still can't access the data.

The system in this case is connected to the internet, so a firewall in between won't help since it needs to allow traffic from all places, but just specific users and their data need to be isolated.

Does it sound sane if we have such a feature for the RGW? The JSON output from user info might look like:

{
  "user_id": "example",
  "user_ip_acl" {
    "allow" [
      "192.168.0.0/24",
      "2001:db8::/64
    ]
  }
}

Wido

[0]: http://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html
