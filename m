From: Michal Jarzabek <stiopa@gmail.com>
Subject: Re: Which IDE do you use for ceph-development?
Date: Fri, 16 Sep 2016 07:15:36 +0100
Message-ID: <CAEFDAA4xjYJk5Y3rnfXs_kKg5Qg1c=TdsMgWEfGko0RvJMNtzQ@mail.gmail.com>
References: <CAA8xDw3OPGikoYF3Knef5tBrCsg+Hvekhyh7BVGJZCq4Yn93Fw@mail.gmail.com>
 <CAA8xDw1RA2RhZ=ERPKK0ZjD1Zc4iWYgm_zSvNHHEdJ+q7FcJag@mail.gmail.com>
 <CAF-wwdEE9KC=4agvTyrxNQcoSjo408SV8DNTfF0Kj2us3Nawkw@mail.gmail.com>
 <CAA8xDw2MirA6WW7ZxSUG_jLzw7md4Ws7JwzBQQ66Vcu3Q1-1jw@mail.gmail.com>
 <CAA8xDw2cU8DN6=SQ3kNCZsXTNrmeZdyKxAhuMV46SjugsGthAw@mail.gmail.com>
 <CA+hcxJTufzt8KkL+Hj93X09OZuyipM-tkVk_v3-mo5NbBDohrQ@mail.gmail.com> <CAF-wwdF=0LVTVrfF-6Q3arq+ETaar=6-H3MbEe5CSvJqV3WKmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32942 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbcIPGPh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2016 02:15:37 -0400
Received: by mail-vk0-f44.google.com with SMTP id 192so12150151vkl.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Sep 2016 23:15:37 -0700 (PDT)
In-Reply-To: <CAF-wwdF=0LVTVrfF-6Q3arq+ETaar=6-H3MbEe5CSvJqV3WKmg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Victor Denisov <vdenisov@mirantis.com>, Elita Lobo <loboelita@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

Hi,

For code completion/navigation YouCompleteMe works great -
https://valloric.github.io/YouCompleteMe.


On Fri, Sep 16, 2016 at 4:14 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
> On Fri, Sep 16, 2016 at 12:15 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>> Hi Elita,
>>
>> I'm not sure how familiar you are with Vim, so, probably some advice
>> would be useful.
>>
>> cscope is the most useful tool for navigating c++ code:
>> http://cscope.sourceforge.net/cscope_vim_tutorial.html
>> You need to put this file:
>> http://cscope.sourceforge.net/cscope_maps.vim to your ~/.vim/plugin
>> directory.
>> Then run these commands in ceph src directory:
>>
>> find . -name "*.cc" > cscope.file
>> find . -name "*.h" >> cscope.file
>> find . -name "*.hpp" >> cscope.file
>> find . -name "*.cpp" >> cscope.file
>> find . -name "*.c" >> cscope.file
>>
>> and then
>> cscope -qbk
>
> I used to do it this way but now I just use the cscope vim plugin that
> ships with fedora and just run "gtags" (GNU global tags) to populate
> the tags database.
>
>>
>> Then open any file, but make sure that your current working directory is src.
>>
>> If you want to have more then one plugin use vim pathogen:
>> https://github.com/tpope/vim-pathogen
>
> +1
>
>>
>> I recommend using the following plugins:
>> gundo - allows you to visualize the history of your edits in vim -
>> https://github.com/sjl/gundo.vim
>> nerdtree - allows you to visualize your directory structure -
>> https://github.com/scrooloose/nerdtree
>
> I use commandT here (fuzzy search).
>
>> vim-fugitive - allows you to work with git from vim -
>> https://github.com/tpope/vim-fugitive
>
> +1
>
>>
>> Besides keys that cscope provides you can use some text search
>> features that are built into vim:
>>
>> gf - if you are standing on a file (include file) it will jump to this file.
>> [ + ctrl - i - look for the symbol that you are standing on upwards
>> including all include files.
>
> There are more quick navigation commands (see :help jump-motions and
> :help tag) if you type ":tags" you can see your tag stack and jump
> around within it.
>
>> This is useful because cscope shows all declarations of a function,
>> but this keystroke shows you, most likely, the declaration you need.
>> I say most likely because sometimes it finds forward definition not a
>> real definition, but still it's useful in 96.3 percent of cases)
>
> With the scope plugin you can type the following to find a global defintion:
>
> :cs f g lock_suspend_timeout
>
> Find all callers;
>
> :cs f c lock_suspend_timeout
>
> Find all uses of the symbol;
>
> :cs f s lock_suspend_timeout
>
> Find a file;
>
> :cs f f PG.h
>
> ...and the rest.
>
>         USAGE   :cs find {querytype} {name}
>
>             {querytype} corresponds to the actual cscope line
>             interface numbers as well as default nvi commands:
>
>                 0 or s: Find this C symbol
>                 1 or g: Find this definition
>                 2 or d: Find functions called by this function
>                 3 or c: Find functions calling this function
>                 4 or t: Find this text string
>                 6 or e: Find this egrep pattern
>                 7 or f: Find this file
>                 8 or i: Find files #including this file
>
> Like everyone else I've tried many IDEs but nothing beats vim.
>
> --
> HTH,
> Brad
>
>>
>> Hopefully it was useful.
>>
>> Victor.
>>
>> On Thu, Sep 15, 2016 at 6:55 PM, Elita Lobo <loboelita@gmail.com> wrote:
>>> Hi,
>>>
>>> @Brad,
>>> Hi Brad,
>>>
>>> Thanks again :) ! Will try it out.
>>>
>>> @ Joao, @Mark,
>>> Thanks for the suggestion. I was using vim but I hadn't configured it
>>> to index the files, hence it was becoming very difficult to search for
>>> definitions/declarations etc (Was using grep) . Also, I was hoping I
>>> could build the code on atleast one IDE which could show me all the
>>> local function calls made in each process.
>>> I tried using gdb, added debugging symbols etc but still couldnt trace
>>> the local function calls.
>>> I have somehow managed to figure out the flow using logs/printfs and
>>> experimenting with the ceph commands.
>>>
>>>
>>> Thanks and Regards,
>>> Elita Lobo
>>>
>>>
>>> On Fri, Sep 16, 2016 at 7:15 AM, Elita Lobo <loboelita@gmail.com> wrote:
>>>> Hi Brad,
>>>>
>>>> Thanks :) ! Will try it out. Currently managing with Code Blocks.
>>>>
>>>>
>>>> Regards,
>>>> Elita
>>>>
>>>> On Tue, Sep 13, 2016 at 11:53 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
>>>>>
>>>>> Pretty sure I built it OK in QtCreator but it was some time ago now.
>>>>>
>>>>> --
>>>>> Cheers,
>>>>> Brad
>>>>>
>>>>> On Mon, Sep 12, 2016 at 2:33 AM, Elita Lobo <loboelita@gmail.com> wrote:
>>>>> > Hi,
>>>>> >
>>>>> > I tried using NEtbeans and Eclipse . Netbeans gave this error.
>>>>> > https://paste.fedoraproject.org/426622/61053414/
>>>>> >
>>>>> > And Eclipse is not able to detect header files although I added the
>>>>> > path of the include directory.
>>>>> >
>>>>> > Has anyone successfully built the ceph code on any IDE?
>>>>> >
>>>>> >
>>>>> > Regards,
>>>>> > Elita Lobo
>>>>> > --
>>>>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> > the body of a message to majordomo@vger.kernel.org
>>>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Cheers,
> Brad
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
