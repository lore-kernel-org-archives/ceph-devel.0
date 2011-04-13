From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [qemu-iotests][PATCH] Update rbd support
Date: Tue, 12 Apr 2011 22:42:00 -0700
Message-ID: <c87587fab7b312c58c7d59ac6117eff5@hq.newdream.net>
References: <cover.1302653035.git.josh.durgin@dreamhost.com>
	<1302655665-30101-1-git-send-email-josh.durgin@dreamhost.com>
	<20110413024339.GA16779@lst.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20110413024339.GA16779@lst.de>
List-Unsubscribe: <http://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Christoph Hellwig <hch@lst.de>
Cc: ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, 13 Apr 2011 04:43:39 +0200, Christoph Hellwig <hch@lst.de>
wrote:
>> @@ -43,6 +43,10 @@ _supported_fmt raw
>>  _supported_proto generic
>>  _supported_os Linux
>>
>> +# rbd images are not growable
>> +if [ "$IMGPROTO" = "rbd" ]; then
>> +    _notrun "image protocol $IMGPROTO does not support growable images"
>> +fi
> 
> I suspect we only support the weird writing past size for the
> file protocol, so we should only run the test for it.
> 
> Or does sheepdog do anything special about it?

Sheepdog supports it by truncating to the right size if a write
would be past the end. I'm not sure if other protocols support
it.
