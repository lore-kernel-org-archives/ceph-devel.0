From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v3)
Date: Tue, 01 Jun 2010 10:43:02 +0200
Message-ID: <4C04C816.40409@redhat.com>
References: <20100531193140.GA13993@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20100531193140.GA13993@chb-desktop>
Sender: kvm-owner@vger.kernel.org
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Christian,

Am 31.05.2010 21:31, schrieb Christian Brunner:
> Hi Kevin,
> 
> here is an updated patch for the ceph/rbd driver. I hope that everything 
> is fine now.

I'll try to get to give it a final review later this week. In the
meantime, I would be happy to see another review by someone else.

Do you have some specific tests for the driver or should we extend
qemu-iotests to work with protocols and use only that?

Kevin
