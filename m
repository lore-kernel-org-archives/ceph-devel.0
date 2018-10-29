From: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Subject: Re: librados3
Date: Mon, 29 Oct 2018 12:47:30 +0100
Message-ID: <ecc135ed-8155-11a1-e398-37e30b985897@42on.com>
References: <CAJE9aOP2RWH-rZe6MiXehTo0t2ZuMFOkGgv2OUDoSKghnyFG-Q@mail.gmail.com>
 <CA+aFP1AofvSYEyMcu9Bt46chbBpLCBL-JTyC7h-7H+SvZ2oyRA@mail.gmail.com>
 <CAJE9aOMbnu94-WB3zFB_yRLNZwHOk5AgbhsNip1H2e8XThYsZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJE9aOMbnu94-WB3zFB_yRLNZwHOk5AgbhsNip1H2e8XThYsZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: kefu chai <tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: The Esoteric Order of the Squid Cybernetic <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org



On 10/29/18 12:42 PM, kefu chai wrote:
> + ceph-user for more inputs in hope to get more inputs from librados
> and librbd 's C++ interfaces.
> 
> On Wed, Oct 24, 2018 at 1:34 AM Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> On Tue, Oct 23, 2018 at 11:38 AM kefu chai <tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>> we plan to introduce some non-backward-compatible changes[0] in
>>> librados in the coming nautilus release. to be specific, these changes
>>> are not API/ABI compatible with existing librados2. so i think it's
>>> time to bump up the soversion of librados from 2 to 3.  as bumping up
>>> soversion is a major change in the life cycle of a library, i think we
>>> will expect following changes:
>>>
>>> 0. piggyback more non-backward-compatible changes listed in
>>> https://pad.ceph.com/p/librados3 in this change, so we can have less
>>> soversion bump up.
>>> 1. in nautilus, librados3 and librados3-{dev,devel} will be packaged
>>> instead, librados2* will be maintained in LTS releases.
>>
>> Just note that this is going to have a potential ripple effect on
>> non-Ceph packages that use librbd1 if they are also (incorrectly)
>> specifying a dependency on librados2 [1].
>>
>>> 2. we will have separated C++ and C API librados after this change. so
>>> librados3 will only provide the C API of librados, the C++ API will be
>>> offered by libradospp, (the name may vary if you suggest a better
>>> one). and they will be versioned and packaged separately, and will not
>>> depend on each other. a PR is posted to do this, see [1]
>>
>> Do we have a good idea and/or list about who uses the librados C++
>> API? I seem to vaguely recall perhaps one or so external users. If
>> librgw/RGW and librbd eventually switch over to something similar to
>> the API being worked on by Adam [2] and if there are no external users
>> of the C++ API, should we take the time now to kill all the legacy C++
>> API methods prior to the release of Nautilus?
>>

I know various users who use librados through phprados (PHP) and the
rados-java (Java) bindings.

Those bindings will need to be updated as well.

Qemu and libvirt both mainly use librbd, but they use a very small part
of librados to initiate the connection and set configuration values.

>>> 3. in order to enable user to install librados2 and librados3 at the
>>> same time, libceph-common.so will be versioned since nautilus.
>>> libceph-common.so is an internal shared library used by ceph
>>> libraries, tools and daemons. librados depends on libceph-common.
>>> 4. some executables/libraries' dependencies will be updated
>>> accordingly . for instance, librbd will depend on libradospp.
>>>
>>> if this model works fine, i guess we probably could expand it to librbd.
>>
>> It would be interesting to get a feel for who (if anyone) actually
>> uses the librbd C++ interface before heading down that path. AFAIK,
>> it's probably really only the rbd CLI tool -- and that's basically for
>> the convenience of C++-style containers. If it's not being used by
>> anyone else, perhaps our time could be better spent deprecating the
>> library for external use to focus our development and maintanence
>> efforts on the C (and wrapped-C) interface.
>>

Again, don't forget Qemu/KVM and libvirt who both are very heavy users
of librbd

Wido

>>> any concerns?
>>>
>>> BTW, we discussed this topic last year the same time, see
>>> https://www.spinics.net/lists/ceph-devel/msg38830.html =)
>>>
>>> ---
>>> [0] for instance, https://github.com/ceph/ceph/pull/24498
>>> [1] https://github.com/ceph/ceph/pull/24616
>>> [2] a trello card for librados3:
>>> https://trello.com/c/pmRkawYV/165-librados3-api-update-cleanup
>>>
>>> --
>>> Regards
>>> Kefu Chai
>>
>> [1] https://src.fedoraproject.org/rpms/qemu/blob/f29/f/qemu.spec#_192
>> [2] https://github.com/ceph/ceph/pull/16715
>>
>> --
>> Jason
> 
> 
> 
