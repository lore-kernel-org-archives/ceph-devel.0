From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCHv2] ceph: Fix error handling in ceph_read_iter
Date: Mon, 10 Oct 2016 15:50:42 +0200
Message-ID: <CAOi1vP_piBraimiPzzZL8h9d1WLjJ9h1amYbmsUBSJfprT9u-Q@mail.gmail.com>
References: <1476103098-2925-1-git-send-email-kernel@kyup.com>
 <1476104199-3259-1-git-send-email-kernel@kyup.com> <530F1E79-6653-45F5-BBC6-B1D9F9005D14@redhat.com>
 <57FB93ED.5030602@kyup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57FB93ED.5030602@kyup.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolay Borisov <kernel@kyup.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Oct 10, 2016 at 3:13 PM, Nikolay Borisov <kernel@kyup.com> wrote:
>
>
> On 10/10/2016 04:11 PM, Yan, Zheng wrote:
>>
>>> On 10 Oct 2016, at 20:56, Nikolay Borisov <kernel@kyup.com> wrote:
>>>
>>> In case __ceph_do_getattr returns an error and the retry_op in
>>> ceph_read_iter is not READ_INLINE, then it's possible to invoke
>>> __free_page on a page which is NULL, this naturally leads to a crash.
>>> This can happen when, for example, a process waiting on a MDS reply
>>> receives sigterm.
>>>
>>> Fix this by explicitly checking whether the page is set or not.
>>>
>>> Signed-off-by: Nikolay Borisov <kernel@kyup.com>
>>> Link: http://www.spinics.net/lists/ceph-users/msg31592.html
>>> ---
>>>
>>> Inverted the condition, so resending with correct condition
>>> this time.
>>>
>>> fs/ceph/file.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 3c68e6aee2f0..7413313ae6c8 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -929,7 +929,8 @@ again:
>>>              statret =3D __ceph_do_getattr(inode, page,
>>>                                          CEPH_STAT_CAP_INLINE_DATA, !!p=
age);
>>>              if (statret < 0) {
>>> -                     __free_page(page);
>>> +                    if (page)
>>> +                            __free_page(page);
>>>                      if (statret =3D=3D -ENODATA) {
>>>                              BUG_ON(retry_op !=3D READ_INLINE);
>>>                              goto again;
>>> =E2=80=94
>> Reviewed-by: Yan, Zheng <zyan@redhat.com>
>
> I believe this needs to also be tagged as stable. To whomever is going
> to merge it: can you please do that?

I'll do that.  Zheng, do you see any other issues with the killable
wait here?

Thanks,

                Ilya
