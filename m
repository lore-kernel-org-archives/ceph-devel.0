From: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] block drivers/block: Use octal not symbolic
	permissions
Date: Thu, 24 May 2018 13:40:04 -0600
Message-ID: <501407b0-ae9b-7943-0789-fb1c9959f7fe@kernel.dk>
References: <5e97a292c1ba38a6b5a0caa271d85dc3de1b2aa7.1527105857.git.joe@perches.com>
	<6bf44255-145f-bf14-e254-860731ff9296@kernel.dk>
	<56ee8810463b6c537ca0c10c9f82e6d922acd1f1.camel@perches.com>
	<539cc400-28d7-66df-eb24-77fe95d617a2@kernel.dk>
	<e64c2846b1b9102a52eba7b242f746e7bfff1464.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
In-Reply-To: <e64c2846b1b9102a52eba7b242f746e7bfff1464.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
List-Help: <mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=subscribe>
Sender: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
Errors-To: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, "Ed L. Cashin" <ed.cashin-HInyCGIudOg@public.gmane.org>, Philipp Reisner <philipp.reisner-63ez5xqkn6DQT0dZR+AlfA@public.gmane.org>, Lars Ellenberg <lars.ellenberg-63ez5xqkn6DQT0dZR+AlfA@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Josef Bacik <josef-DigfWCa+lFGyeJad7bwFQA@public.gmane.org>, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Alex Elder <elder-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Philip Kelleher <pjk1939-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nbd-2H2hN8V1XRtuHlm7Suoebg@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 5/24/18 7:01 AM, Joe Perches wrote:
> On Thu, 2018-05-24 at 06:47 -0600, Jens Axboe wrote:
>> On 5/23/18 4:35 PM, Joe Perches wrote:
>>> On Wed, 2018-05-23 at 15:27 -0600, Jens Axboe wrote:
>>>> On 5/23/18 2:05 PM, Joe Perches wrote:
>>>>> Convert the S_<FOO> symbolic permissions to their octal equivalents as
>>>>> using octal and not symbolic permissions is preferred by many as more
>>>>> readable.
>>>>>
>>>>> see: https://lkml.org/lkml/2016/8/2/1945
>>>>>
>>>>> Done with automated conversion via:
>>>>> $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
>>>>>
>>>>> Miscellanea:
>>>>>
>>>>> o Wrapped modified multi-line calls to a single line where appropriate
>>>>> o Realign modified multi-line calls to open parenthesis
>>>>
>>>> Honestly, I see this as pretty needless churn.
>>>
>>> btw:
>>>
>>> There is currently a mixture of symbolic and octal
>>> permissions uses in block and drivers/block
>>>
>>> ie: 94 octal and 146 symbolic uses.
>>>
>>> If this is applied, all would become octal.
>>
>> That does help justify the change. My main worry here is creating
>> unnecessary conflicts, which is always annoying. But it's even more
>> annoying when the change creating the conflict isn't really that
>> important at all. Case in point, the patch doesn't apply to the
>> for-4.18/block branch that it should go into...
> 
> Done against most recent -next as it's basically impossible
> to do anything against multiple private trees.
> 
> Also, the script that generated the patch is in the changelog
> so it's simple to rerun.

Alright, applied, thanks.

-- 
Jens Axboe
