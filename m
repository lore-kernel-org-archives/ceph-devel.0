From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: Which IDE do you use for ceph-development?
Date: Thu, 15 Sep 2016 19:15:05 -0700
Message-ID: <CA+hcxJTufzt8KkL+Hj93X09OZuyipM-tkVk_v3-mo5NbBDohrQ@mail.gmail.com>
References: <CAA8xDw3OPGikoYF3Knef5tBrCsg+Hvekhyh7BVGJZCq4Yn93Fw@mail.gmail.com>
 <CAA8xDw1RA2RhZ=ERPKK0ZjD1Zc4iWYgm_zSvNHHEdJ+q7FcJag@mail.gmail.com>
 <CAF-wwdEE9KC=4agvTyrxNQcoSjo408SV8DNTfF0Kj2us3Nawkw@mail.gmail.com>
 <CAA8xDw2MirA6WW7ZxSUG_jLzw7md4Ws7JwzBQQ66Vcu3Q1-1jw@mail.gmail.com> <CAA8xDw2cU8DN6=SQ3kNCZsXTNrmeZdyKxAhuMV46SjugsGthAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35844 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753682AbcIPCPH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2016 22:15:07 -0400
Received: by mail-vk0-f43.google.com with SMTP id m62so6979788vkd.3
        for <ceph-devel@vger.kernel.org>; Thu, 15 Sep 2016 19:15:06 -0700 (PDT)
In-Reply-To: <CAA8xDw2cU8DN6=SQ3kNCZsXTNrmeZdyKxAhuMV46SjugsGthAw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elita Lobo <loboelita@gmail.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Elita,

I'm not sure how familiar you are with Vim, so, probably some advice
would be useful.

cscope is the most useful tool for navigating c++ code:
http://cscope.sourceforge.net/cscope_vim_tutorial.html
You need to put this file:
http://cscope.sourceforge.net/cscope_maps.vim to your ~/.vim/plugin
directory.
Then run these commands in ceph src directory:

find . -name "*.cc" > cscope.file
find . -name "*.h" >> cscope.file
find . -name "*.hpp" >> cscope.file
find . -name "*.cpp" >> cscope.file
find . -name "*.c" >> cscope.file

and then
cscope -qbk

Then open any file, but make sure that your current working directory is src.

If you want to have more then one plugin use vim pathogen:
https://github.com/tpope/vim-pathogen

I recommend using the following plugins:
gundo - allows you to visualize the history of your edits in vim -
https://github.com/sjl/gundo.vim
nerdtree - allows you to visualize your directory structure -
https://github.com/scrooloose/nerdtree
vim-fugitive - allows you to work with git from vim -
https://github.com/tpope/vim-fugitive

Besides keys that cscope provides you can use some text search
features that are built into vim:

gf - if you are standing on a file (include file) it will jump to this file.
[ + ctrl - i - look for the symbol that you are standing on upwards
including all include files.
This is useful because cscope shows all declarations of a function,
but this keystroke shows you, most likely, the declaration you need.
I say most likely because sometimes it finds forward definition not a
real definition, but still it's useful in 96.3 percent of cases)

Hopefully it was useful.

Victor.

On Thu, Sep 15, 2016 at 6:55 PM, Elita Lobo <loboelita@gmail.com> wrote:
> Hi,
>
> @Brad,
> Hi Brad,
>
> Thanks again :) ! Will try it out.
>
> @ Joao, @Mark,
> Thanks for the suggestion. I was using vim but I hadn't configured it
> to index the files, hence it was becoming very difficult to search for
> definitions/declarations etc (Was using grep) . Also, I was hoping I
> could build the code on atleast one IDE which could show me all the
> local function calls made in each process.
> I tried using gdb, added debugging symbols etc but still couldnt trace
> the local function calls.
> I have somehow managed to figure out the flow using logs/printfs and
> experimenting with the ceph commands.
>
>
> Thanks and Regards,
> Elita Lobo
>
>
> On Fri, Sep 16, 2016 at 7:15 AM, Elita Lobo <loboelita@gmail.com> wrote:
>> Hi Brad,
>>
>> Thanks :) ! Will try it out. Currently managing with Code Blocks.
>>
>>
>> Regards,
>> Elita
>>
>> On Tue, Sep 13, 2016 at 11:53 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
>>>
>>> Pretty sure I built it OK in QtCreator but it was some time ago now.
>>>
>>> --
>>> Cheers,
>>> Brad
>>>
>>> On Mon, Sep 12, 2016 at 2:33 AM, Elita Lobo <loboelita@gmail.com> wrote:
>>> > Hi,
>>> >
>>> > I tried using NEtbeans and Eclipse . Netbeans gave this error.
>>> > https://paste.fedoraproject.org/426622/61053414/
>>> >
>>> > And Eclipse is not able to detect header files although I added the
>>> > path of the include directory.
>>> >
>>> > Has anyone successfully built the ceph code on any IDE?
>>> >
>>> >
>>> > Regards,
>>> > Elita Lobo
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> > the body of a message to majordomo@vger.kernel.org
>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
