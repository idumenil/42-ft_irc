# Nom du programme
NAME	= ircserv

# Compilation
CC		= c++
CFLAGS	= -Werror -Wextra -Wall -std=c++98

# Construction des fichiers
INC_PATH	= ./includes/
INC			= -I $(INC_PATH)

SRC_PATH	= ./sources/
SRC			= $(wildcard $(SRC_PATH)*.cpp)

OBJ_PATH	= ./objects/
OBJ			= $(SRC:$(SRC_PATH)%.cpp=$(OBJ_PATH)%.o)

# Librairies pour la connexion chiffree ssl
LIB			= -lssl -lcrypto

# Regle de contruction
all: $(OBJ_PATH) $(NAME)

# Regle de construction des fichiers objets
$(OBJ_PATH):
	mkdir -p $(OBJ_PATH)

$(OBJ_PATH)%.o: $(SRC_PATH)%.cpp
	$(CC) $(CFLAGS) -c $< -o $@ $(INC)

# Regle de construction des programmes
$(NAME): $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@ $(INC) $(LIB)

# Regles de nettoyage
clean:
	rm -rf $(OBJ_PATH)

fclean: clean
	rm -f $(NAME)

# Remake
re: fclean all

.PHONY: all re clean fclean