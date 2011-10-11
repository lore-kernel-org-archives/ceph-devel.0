From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] [PATCH 4/5] buf: implement generic virBufferEscape
Date: Tue, 11 Oct 2011 11:39:35 +0100
Message-ID: <20111011103935.GB16057@redhat.com>
References: <1316492023-17749-1-git-send-email-sage@newdream.net>
 <1316492023-17749-5-git-send-email-sage@newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44916 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668Ab1JKKjz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Oct 2011 06:39:55 -0400
Content-Disposition: inline
In-Reply-To: <1316492023-17749-5-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Mon, Sep 19, 2011 at 09:13:42PM -0700, Sage Weil wrote:
> Implement a generic helper to escape a given set of characters with a
> leading '\'.  Generalizes virBufferEscapeSexpr().
> 
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
>  src/libvirt_private.syms |    1 +
>  src/util/buf.c           |   33 ++++++++++++++++++++++++++-------
>  src/util/buf.h           |    1 +
>  3 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/src/libvirt_private.syms b/src/libvirt_private.syms
> index 830222b..d230fab 100644
> --- a/src/libvirt_private.syms
> +++ b/src/libvirt_private.syms
> @@ -25,6 +25,7 @@ virBufferAddChar;
>  virBufferAsprintf;
>  virBufferContentAndReset;
>  virBufferError;
> +virBufferEscape;
>  virBufferEscapeSexpr;
>  virBufferEscapeString;
>  virBufferFreeAndReset;
> diff --git a/src/util/buf.c b/src/util/buf.c
> index 5002486..7d0d2d3 100644
> --- a/src/util/buf.c
> +++ b/src/util/buf.c
> @@ -383,9 +383,29 @@ virBufferEscapeSexpr(const virBufferPtr buf,
>                       const char *format,
>                       const char *str)
>  {
> +    virBufferEscape(buf, "\\\'", format, str);
> +}
> +
> +/**
> + * virBufferEscape:
> + * @buf:  the buffer to dump
> + * @toescape: NULL-terminated list of characters to escape
> + * @format: a printf like format string but with only one %s parameter
> + * @str:  the string argument which need to be escaped
> + *
> + * Do a formatted print with a single string to a buffer.  Any characters
> + * in the provided list are escaped with a preceeding \.
> + */
> +void
> +virBufferEscape(const virBufferPtr buf,
> +                const char *toescape,
> +                const char *format,
> +                const char *str)
> +{
>      int len;
>      char *escaped, *out;
>      const char *cur;
> +    const char *p;
>  
>      if ((format == NULL) || (buf == NULL) || (str == NULL))
>          return;
> @@ -408,14 +428,13 @@ virBufferEscapeSexpr(const virBufferPtr buf,
>      cur = str;
>      out = escaped;
>      while (*cur != 0) {
> -        switch (*cur) {
> -        case '\\':
> -        case '\'':
> -            *out++ = '\\';
> -            /* fallthrough */
> -        default:
> -            *out++ = *cur;
> +        for (p = toescape; *p; ++p) {
> +            if (*cur == *p) {
> +                *out++ = '\\';
> +                break;
> +            }
>          }
> +        *out++ = *cur;
>          cur++;
>      }
>      *out = 0;
> diff --git a/src/util/buf.h b/src/util/buf.h
> index 06d01ba..e545ed9 100644
> --- a/src/util/buf.h
> +++ b/src/util/buf.h
> @@ -50,6 +50,7 @@ void virBufferStrcat(const virBufferPtr buf, ...)
>    ATTRIBUTE_SENTINEL;
>  void virBufferEscapeString(const virBufferPtr buf, const char *format, const char *str);
>  void virBufferEscapeSexpr(const virBufferPtr buf, const char *format, const char *str);
> +void virBufferEscape(const virBufferPtr buf, const char *toescape, const char *format, const char *str);
>  void virBufferURIEncodeString (const virBufferPtr buf, const char *str);
>  
>  # define virBufferAddLit(buf_, literal_string_) \

ACK, trivial isolated patch

Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
