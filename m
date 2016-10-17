From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ceph: Fix uninitialized dentry pointer in ceph_real_mount()
Date: Mon, 17 Oct 2016 09:46:07 +0200
Message-ID: <CAMuHMdUrQ9J6xu9+wwXBWeaYg_k=GkRtaTH6ZxfFc2YWeVq5Ug@mail.gmail.com>
References: <1476371737-2116-1-git-send-email-geert@linux-m68k.org> <CAAM7YAkuzcCB45Jx3nqQjyt3mUNmgYsq3cSG707ga_-mQ8ag8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAkuzcCB45Jx3nqQjyt3mUNmgYsq3cSG707ga_-mQ8ag8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Zheng Yan <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hi Zheng,

On Fri, Oct 14, 2016 at 4:47 AM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Thu, Oct 13, 2016 at 11:15 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>>     fs/ceph/super.c: In function =E2=80=98ceph_real_mount=E2=80=99:
>>     fs/ceph/super.c:818: warning: =E2=80=98root=E2=80=99 may be used uni=
nitialized in this function
>>
>> If s_root is already valid, dentry pointer root is never initialized,
>> and returned by ceph_real_mount(). This will cause a crash later when
>> the caller dereferences the pointer.
>>
>> Fix this by initializing root early.
>>
>> Fixes: ce2728aaa82bbeba ("ceph: avoid accessing / when mounting a subpat=
h")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> Compile-tested only.
>> ---
>>  fs/ceph/super.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>> index a29ffce981879d5f..794c5fd0e0cf5e45 100644
>> --- a/fs/ceph/super.c
>> +++ b/fs/ceph/super.c
>> @@ -821,7 +821,8 @@ static struct dentry *ceph_real_mount(struct ceph_fs=
_client *fsc)
>>         dout("mount start %p\n", fsc);
>>         mutex_lock(&fsc->client->mount_mutex);
>>
>> -       if (!fsc->sb->s_root) {
>> +       root =3D fsc->sb->s_root;
>> +       if (!root) {
>>                 const char *path;
>>                 err =3D __ceph_open_session(fsc->client, started);
>>                 if (err < 0)
>
> For sb->s_root is not NULL case, we also need to increase sb->s_root's
> reference count.

OK

> I applied this patch and fixed it.

Thanks for handling!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
