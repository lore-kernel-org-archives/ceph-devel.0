From: Sage Weil <sage@newdream.net>
Subject: Re: the cpu optimize in ceph
Date: Fri, 12 Dec 2014 06:42:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412120640330.23559@cobra.newdream.net>
References: <CANE=7sWDLbEZ6RSkkfm+exJDhiU6mQfL3EMhAseRWCmmC13brg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47968 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967919AbaLLOmx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Dec 2014 09:42:53 -0500
In-Reply-To: <CANE=7sWDLbEZ6RSkkfm+exJDhiU6mQfL3EMhAseRWCmmC13brg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?s9jQxdTz?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 12 Dec 2014, ??? wrote:
> hi, cephers:
> 
>      Now, I want to reduce the cpu usage rate by osd in full ssd
> cluster.  In my test case, ceph run out of cpu, the cpu idle is about
> 10%.
> 
>      The cpu in my cluster is Intel(R) Core(TM) i5-4570 CPU @ 3.20GHz.
> 
>      Can you give me some suggestion?
> 
>      Thanks.
> 
> There are the cpu usage rate by perf tools.

Can you generate call graph info?

> +   5.46%  ceph-osd  libtcmalloc.so.4.1.0  [.] 0x0000000000017dea
> +   2.45%  ceph-osd  libtcmalloc.so.4.1.0  [.]
> tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*,
> unsigned long, int)
> +   1.81%  ceph-osd  libc-2.12.so          [.] memcpy

Curious who teh callers are here

> +   1.75%  ceph-osd  libpthread-2.12.so    [.] pthread_mutex_trylock
> +   1.66%  ceph-osd  [kernel.kallsyms]     [k] _raw_spin_lock
> +   1.49%  ceph-osd  libtcmalloc.so.4.1.0  [.] operator delete(void*)
> +   1.47%  ceph-osd  libpthread-2.12.so    [.] pthread_mutex_unlock
> +   1.14%  ceph-osd  libstdc++.so.6.0.13   [.] std::basic_string<char,
> std::char_traits<char>, std::allocator<char>
> >::basic_string(std::string const&)

here

> +   1.13%  ceph-osd  libc-2.12.so          [.] _IO_vfscanf

here

> +   1.10%  ceph-osd  ceph-osd              [.] ceph::buffer::ptr::release()
> +   1.09%  ceph-osd  libc-2.12.so          [.] vfprintf

here

> +   1.00%  ceph-osd  [kernel.kallsyms]     [k] page_fault
> +   0.96%  ceph-osd  ceph-osd              [.]
> ceph::buffer::list::append(char const*, unsigned int)
> +   0.94%  ceph-osd  ceph-osd              [.] Mutex::Lock(bool)
> +   0.91%  ceph-osd  libstdc++.so.6.0.13   [.] 0x000000000008095f
> +   0.90%  ceph-osd  libstdc++.so.6.0.13   [.]
> std::string::compare(std::string const&) const+   0.88%  ceph-osd
> [vdso]                [.] 0x0000000000000a08+   0.87%  ceph-osd
> ceph-osd              [.]
> __gnu_cxx::__enable_if<std::__is_char<char>::__value, bool>::__type
> std::operator==<char>(std::basic_string<char, std::char_traits<char>,
> std::alloca+   0.86%  ceph-osd  libstdc++.so.6.0.13   [.]
> std::basic_string<char, std::char_traits<char>, std::allocator<char>
> >::~basic_string()+   0.76%  ceph-osd  [kernel.kallsyms]     [k]
> system_call+   0.75%  ceph-osd  libstdc++.so.6.0.13   [.]
> std::basic_ostream<char, std::char_traits<char> >&
> std::__ostream_insert<char, std::char_traits<char>
> >(std::basic_ostream<char, std::char_traits<cha
> +   0.73%  ceph-osd  libstdc++.so.6.0.13   [.]
> std::basic_streambuf<char, std::char_traits<char> >::xsputn(char
> const*, long)
> +   0.73%  ceph-osd  ceph-osd              [.]
> ceph::buffer::ptr::ptr(ceph::buffer::ptr const&)
> +   0.71%  ceph-osd  [kernel.kallsyms]     [k] try_to_wake_up
> +   0.70%  ceph-osd  ceph-osd              [.]
> std::less<ghobject_t>::operator()(ghobject_t const&, ghobject_t
> const&) const
> +   0.67%  ceph-osd  [kernel.kallsyms]     [k] copy_user_enhanced_fast_string
> +   0.63%  ceph-osd  libc-2.12.so          [.] __strlen_sse42

and here.

Also, I think the buffer::list::append() is a good target to 
optimize.  We should be able to avoid several pointer derefs if we 
cache a pointer into the last segment.  The trick will likely be 
invalidating that if the buffer is otherwise modified.

sage

> +   0.61%  ceph-osd  [kernel.kallsyms]     [k] update_curr
> +   0.60%  ceph-osd  libstdc++.so.6.0.13   [.]
> std::ostreambuf_iterator<char, std::char_traits<char> >
> std::num_put<char, std::ostreambuf_iterator<char,
> std::char_traits<char> > >::_M_insert_int<l
> +   0.58%  ceph-osd  libtcmalloc.so.4.1.0  [.] operator new(unsigned long)
> +   0.58%  ceph-osd  libtcmalloc.so.4.1.0  [.]
> tcmalloc::CentralFreeList::FetchFromSpans()
> +   0.55%  ceph-osd  ceph-osd              [.]
> ceph::buffer::ptr::append(char const*, unsigned int)
> +   0.55%  ceph-osd  libstdc++.so.6.0.13   [.] std::ostream&
> std::ostream::_M_insert<long>(long)
> +   0.53%  ceph-osd  ceph-osd              [.] ceph::log::Log::flush()
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
