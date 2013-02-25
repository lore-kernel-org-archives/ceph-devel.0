From: Wido den Hollander <wido@42on.com>
Subject: Re: ceph keyring
Date: Mon, 25 Feb 2013 09:53:46 +0100
Message-ID: <512B269A.5020503@42on.com>
References: <CAJH6TXgQ2Z_k=Prs625bbX1TWEwUmQRY8wsHhxM5OOU73fiWOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:38081 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754959Ab3BYIxt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Feb 2013 03:53:49 -0500
In-Reply-To: <CAJH6TXgQ2Z_k=Prs625bbX1TWEwUmQRY8wsHhxM5OOU73fiWOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 02/20/2013 10:01 AM, Gandalf Corvotempesta wrote:
> I'm trying to configure RGW following this guide:
> http://ceph.com/docs/master/radosgw/config/
>
> I have some questions about keyring. Should keyring files copied on
> each cluster node?
> For example, these commands:
>
> sudo ceph-authtool --create-keyring /etc/ceph/keyring.radosgw.gateway
> sudo chmod +r /etc/ceph/keyring.radosgw.gateway
> sudo ceph-authtool /etc/ceph/keyring.radosgw.gateway -n
> client.radosgw.gateway --gen-key
> sudo ceph-authtool -n client.radosgw.gateway --cap osd 'allow rwx'
> --cap mon 'allow r' /etc/ceph/keyring.radosgw.gateway
> sudo ceph -k /etc/ceph/ceph.keyring auth add client.radosgw.gateway -i
> /etc/ceph/keyring.radosgw.gateway
>
> on which node should be ran and the generated keyfile, should be
> synced on each node?
> --

You need to copy the keyring file to the node where the RGW will be running.

The RGW will use the key to authenticate with the cluster.

Wido

P.S.: This would be something for the -users list.

> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
