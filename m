From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH v5 4/4] rbd: Add bdrv_truncate
	implementation
Date: Thu, 26 May 2011 16:09:36 -0700
Message-ID: <4DDEDDB0.3010501@dreamhost.com>
References: <1306355687-4647-1-git-send-email-josh.durgin@dreamhost.com>
	<1306355687-4647-5-git-send-email-josh.durgin@dreamhost.com>
	<4DDE09D4.6020705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <4DDE09D4.6020705@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Kevin Wolf <kwolf@redhat.com>
Cc: ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, Christian Brunner <chb@muc.de>
List-Id: ceph-devel.vger.kernel.org

On 05/26/2011 01:05 AM, Kevin Wolf wrote:
> Am 25.05.2011 22:34, schrieb Josh Durgin:
>> Signed-off-by: Josh Durgin<josh.durgin@dreamhost.com>
>> ---
>>   block/rbd.c |   15 +++++++++++++++
>>   1 files changed, 15 insertions(+), 0 deletions(-)
>>
>> diff --git a/block/rbd.c b/block/rbd.c
>> index a44d160..b95b1eb 100644
>> --- a/block/rbd.c
>> +++ b/block/rbd.c
>> @@ -688,6 +688,20 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
>>       return info.size;
>>   }
>>
>> +static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset)
>> +{
>> +    BDRVRBDState *s = bs->opaque;
>> +    int r;
>> +
>> +    r = rbd_resize(s->image, offset);
>> +    if (r<  0) {
>> +        error_report("failed to resize rbd image");
>> +        return -EIO;
>> +    }
>
> Don't print an error message here. The caller will do it, too, so we end
> up with two error messages saying the same.

Fixed.

> What kind of error code does rbd_resize return? If it is a valid errno
> value, you should return r instead of turning it into EIO.
>
> Kevin

The error code is a standard errno value.

Josh
