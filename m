From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: New configuration / command line handling
Date: Thu, 13 Dec 2012 02:15:01 +0100
Message-ID: <CAN04cT49Li9u7CXm1rPZTVvQBE+JEneQa37mO_UE4_=EZJa87A@mail.gmail.com>
References: <CAN04cT6XTzaqQuLyQUUWY34F9ZQ1xoLwK3uJt5+SS-Ui+MCUCg@mail.gmail.com>
	<50BD1EE9.909@inktank.com>
	<CAN04cT5UgSipUOG9Ch=nXOwh-AGvmhtFzHOKDamuN6zxBtg9iQ@mail.gmail.com>
	<50BEB9B9.3080005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60340 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab2LMBPD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 20:15:03 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so1481245vby.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 17:15:01 -0800 (PST)
In-Reply-To: <50BEB9B9.3080005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

Alright, I did some work on this. My time was limited last week, so it
took a while. Nonetheless, I have some changes pushed to github
(github.com/roaldvanloon, ceph, branch wip-config).

Most of the time went into thinking about a nice & clean interface
which A) would make porting the existing code fairly easy and B) would
be easy extensible;

On Wed, Dec 5, 2012 at 4:04 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
>
> I'm not sure this is the best solution, but we have a small number of
> types of config values. We could have a getter for each type (like
> md_config_t::get_val(), but nicer to use in C++ and asserting that
> the configuration option is valid and of the appropriate type), i.e.:
>
>     uint64_t get_uint64_t(const std::string &name);
>
> This could work for internal users (i.e. anyone using g_conf->foo right
> now). The library users (e.g. rados_conf_get()) would still want an
> interface like md_config_t::get_val() that returns an error if the
> option doesn't exist.


My first idea was to make nice templated 'Value' classes, and use a
CRTP pattern or something to make it cloneable and dynamic_castable to
different types at runtime. However, this would make the whole shebang
both complicated and more error prone. So... I dropped that idea.

I think I have found a workable solution, so please check it out in
git :-) Basically it boils down to the following: the configuration
object creates an 'active' set of parameters, eg this is the set of
all config values for any given entity (like mon.alpha or osd.55).
This set is accessible using;

(Configuration*)->active()

This returns a Collection* that contains all Parameter* objects
accessible by parameter key;

(Configuration*)->active()->param("osd data") /* all [\._-] is
translated to a space btw */

Internally, all values are stored as std::strings, and to get it you can do;

(Configuration*)->active()->param("osd data")->get()

If you want in a different type, you can do;

(Configuration*)->active()->param("osd data")->as<T>()

It tries to do lexical casts as good as can be (returning an empty T()
if all fails), but of course this needs some flexibility when you want
an uuid_d for instance. So you need to make small overloads for this
method. For uuid_d these are;

template<>
uuid_d Parameter::as<uuid_d>() const
{
  uuid_d v;
  v.parse(get().c_str());
  return v;
}

template<>
void Parameter::from<uuid_d>(const uuid_d& u)
{
  char b[37];
  uuid_unparse(u.uuid, b);
  this->set(std::string(b));
}

Then the following will work and will give you an uuid_d object loaded
with the right fsid;

uuid_d my_fsid = (Configuration*)->active()->param("fsid")->as<uuid_d>();

For the global config in g_ceph_context, I created some macros for ease of use;

uuid_d my_fsid = CEPH_CFG_UUID("fsid");

(which actually does; CEPH_CFG(uuid_d, "fsid"), see the macro
definitions in config.h)

Default config values are defined in defaults.h. If you want to have
non-std types here, you also have to create a 'validator' for that
type that checks the config input (command line, config file) for
validness. See Validators.{cc,h}.

Still work in progress (I have a backlog filled with weirdness and
bugs, and also env params are not yet working), but I think this is a
nice way to access config values.

Looking forward for your comments,

Cheers,

- Roald


PS; metavalue parsing is now transparent, so also on the command line.
Great for infinite loops;

dev src # ./ceph-osd2 --id \$id
Segmentation fault
dev src #

Like I said, still a lot of bugs to squash :-)
